import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/reporte_provider.dart';

class ReportesScreen extends ConsumerStatefulWidget {
  const ReportesScreen({super.key});

  @override
  ConsumerState<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends ConsumerState<ReportesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(reportesProvider.notifier).load(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Resumen', icon: Icon(Icons.summarize)),
            Tab(text: 'Ventas', icon: Icon(Icons.trending_up)),
            Tab(text: 'Productos', icon: Icon(Icons.inventory)),
          ],
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildSelectorFechas(state),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildResumen(state),
                      _buildVentas(state),
                      _buildProductos(state),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSelectorFechas(ReportesState state) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => _selectFecha(true),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Desde',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: Text(dateFormat.format(state.fechaInicio)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: InkWell(
              onTap: () => _selectFecha(false),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Hasta',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: Text(dateFormat.format(state.fechaFin)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: '7', label: Text('7D')),
              ButtonSegment(value: '30', label: Text('30D')),
              ButtonSegment(value: '90', label: Text('90D')),
            ],
            selected: {'30'},
            onSelectionChanged: (selection) {
              final dias = int.parse(selection.first);
              final fin = DateTime.now();
              final inicio = fin.subtract(Duration(days: dias));
              ref.read(reportesProvider.notifier).setRangoFechas(inicio, fin);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _selectFecha(bool esInicio) async {
    final state = ref.read(reportesProvider);
    final initialDate = esInicio ? state.fechaInicio : state.fechaFin;
    final firstDate = esInicio ? DateTime(2020) : state.fechaInicio;
    final lastDate = esInicio ? state.fechaFin : DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      if (esInicio) {
        ref.read(reportesProvider.notifier).setRangoFechas(picked, state.fechaFin);
      } else {
        ref.read(reportesProvider.notifier).setRangoFechas(state.fechaInicio, picked);
      }
    }
  }

  Widget _buildResumen(ReportesState state) {
    final currencyFormat = NumberFormat.currency(symbol: 'Bs.', decimalDigits: 2);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Resumen del Período', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildMetricCard('Total Ventas', currencyFormat.format(state.totalVentas), Icons.attach_money, Colors.green)),
            const SizedBox(width: 16),
            Expanded(child: _buildMetricCard('Promedio/Venta', currencyFormat.format(state.promedioVenta), Icons.analytics, Colors.blue)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildMetricCard('Días con Ventas', '${state.ventasPorFecha.length}', Icons.calendar_today, Colors.purple)),
            const SizedBox(width: 16),
            Expanded(child: _buildMetricCard('Ventas por Método', '${state.ventasPorMetodo.length}', Icons.payment, Colors.orange)),
          ],
        ),
        const SizedBox(height: 24),
        Text('Ventas por Método de Pago', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...state.ventasPorMetodo.entries.map((entry) => Card(
          child: ListTile(
            leading: Icon(_getMetodoIcon(entry.key), color: _getMetodoColor(entry.key)),
            title: Text(entry.key.toUpperCase()),
            trailing: Text(currencyFormat.format(entry.value), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        )),
      ],
    );
  }

  Widget _buildMetricCard(String titulo, String valor, IconData icono, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icono, size: 32, color: color),
            const SizedBox(height: 8),
            Text(valor, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(titulo, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildVentas(ReportesState state) {
    if (state.ventasPorFecha.isEmpty) {
      return const Center(child: Text('No hay ventas en el período seleccionado'));
    }

    final currencyFormat = NumberFormat.currency(symbol: 'Bs.', decimalDigits: 2);
    final dateFormat = DateFormat('dd/MM');

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.ventasPorFecha.length,
      itemBuilder: (context, index) {
        final reporte = state.ventasPorFecha[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(dateFormat.format(reporte.fecha)),
            ),
            title: Text(dateFormat.format(reporte.fecha)),
            subtitle: Text('${reporte.cantidadVentas} ventas'),
            trailing: Text(
              currencyFormat.format(reporte.totalVentas),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductos(ReportesState state) {
    if (state.productosMasVendidos.isEmpty) {
      return const Center(child: Text('No hay ventas en el período seleccionado'));
    }

    final currencyFormat = NumberFormat.currency(symbol: 'Bs.', decimalDigits: 2);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.productosMasVendidos.length,
      itemBuilder: (context, index) {
        final reporte = state.productosMasVendidos[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getRankColor(index),
              child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
            ),
            title: Text(reporte.producto.nombre),
            subtitle: Text('${reporte.cantidadVendida} unidades vendidas'),
            trailing: Text(
              currencyFormat.format(reporte.totalVendido),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }

  IconData _getMetodoIcon(String metodo) {
    switch (metodo) {
      case 'efectivo':
        return Icons.money;
      case 'tarjeta':
        return Icons.credit_card;
      case 'qr':
        return Icons.qr_code;
      default:
        return Icons.payment;
    }
  }

  Color _getMetodoColor(String metodo) {
    switch (metodo) {
      case 'efectivo':
        return Colors.green;
      case 'tarjeta':
        return Colors.blue;
      case 'qr':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}