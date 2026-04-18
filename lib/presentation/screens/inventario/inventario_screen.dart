import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/inventario_provider.dart';
import '../../../data/datasources/database.dart';

class InventarioScreen extends ConsumerStatefulWidget {
  const InventarioScreen({super.key});

  @override
  ConsumerState<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends ConsumerState<InventarioScreen> with SingleTickerProviderStateMixin {
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
    final inventarioState = ref.watch(inventarioProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Inventario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(inventarioProvider.notifier).load(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Tab(text: 'Resumen', icon: Icon(Icons.dashboard)),
            const Tab(text: 'Stock', icon: Icon(Icons.inventory)),
            const Tab(text: 'Alertas', icon: Icon(Icons.warning)),
          ],
        ),
      ),
      body: inventarioState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildResumen(inventarioState),
                _buildStock(inventarioState),
                _buildAlertas(inventarioState),
              ],
            ),
    );
  }

  Widget _buildResumen(InventarioState state) {
    final resumen = state.resumen;
    if (resumen == null) return const Center(child: Text('Sin datos'));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Resumen General',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildResumenCard('Productos', '${resumen.totalProductos}', Icons.inventory_2, Colors.blue)),
            const SizedBox(width: 16),
            Expanded(child: _buildResumenCard('Lotes', '${resumen.totalLotes}', Icons.tag, Colors.green)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildResumenCard('Stock Bajo', '${resumen.productosStockBajo}', Icons.trending_down, Colors.orange)),
            const SizedBox(width: 16),
            Expanded(child: _buildResumenCard('Por Vencer', '${resumen.lotesPorVencer}', Icons.schedule, Colors.amber)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildResumenCard('Vencidos', '${resumen.lotesVencidos}', Icons.error, Colors.red)),
            const SizedBox(width: 16),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 24),
        if (resumen.productosStockBajo > 0 || resumen.lotesPorVencer > 0 || resumen.lotesVencidos > 0) ...[
          Text(
            'Acciones Recomendadas',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (resumen.productosStockBajo > 0)
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: Text('${resumen.productosStockBajo} productos con stock bajo'),
              subtitle: const Text('Revisar y reponer inventario'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _tabController.animateTo(2),
            ),
          if (resumen.lotesPorVencer > 0)
            ListTile(
              leading: const Icon(Icons.schedule, color: Colors.amber),
              title: Text('${resumen.lotesPorVencer} lotes por vencer en 30 días'),
              subtitle: const Text('Considerar promoción o rotación'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _tabController.animateTo(2),
            ),
          if (resumen.lotesVencidos > 0)
            ListTile(
              leading: const Icon(Icons.error, color: Colors.red),
              title: Text('${resumen.lotesVencidos} lotes vencidos'),
              subtitle: const Text('Retirar del inventario'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _tabController.animateTo(2),
            ),
        ],
      ],
    );
  }

  Widget _buildResumenCard(String titulo, String valor, IconData icono, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icono, size: 32, color: color),
            const SizedBox(height: 8),
            Text(valor, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            Text(titulo, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildStock(InventarioState state) {
    if (state.lotes.isEmpty) {
      return const Center(child: Text('No hay lotes en inventario'));
    }

    final groupedLotes = <int, List<Lote>>{};
    for (final lote in state.lotes) {
      groupedLotes.putIfAbsent(lote.productoId, () => []).add(lote);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedLotes.length,
      itemBuilder: (context, index) {
        final productoId = groupedLotes.keys.elementAt(index);
        final lotes = groupedLotes[productoId]!;
        final infoAsync = ref.watch(productoInfoProvider(productoId));

        return infoAsync.when(
          data: (info) {
            final producto = info['producto'] as Producto?;
            if (producto == null) return const SizedBox();

            final totalStock = lotes.fold(0, (sum, l) => sum + l.cantidadActual);
            final isCritico = totalStock < producto.stockMinimo;

            return Card(
              color: isCritico ? Colors.red.shade50 : null,
              child: ExpansionTile(
                leading: Icon(
                  isCritico ? Icons.warning : Icons.inventory,
                  color: isCritico ? Colors.red : null,
                ),
                title: Text(producto.nombre),
                subtitle: Text('Stock total: $totalStock - Mínimo: ${producto.stockMinimo}'),
                children: lotes.map((lote) => _buildLoteTile(lote, producto)).toList(),
              ),
            );
          },
          loading: () => const ListTile(title: Text('Cargando...')),
          error: (e, _) => ListTile(title: Text('Error: $e')),
        );
      },
    );
  }

  Widget _buildLoteTile(Lote lote, Producto producto) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    String estadoVencimiento = '';

    if (lote.fechaVencimiento != null) {
      final now = DateTime.now();
      if (lote.fechaVencimiento!.isBefore(now)) {
        estadoVencimiento = ' (VENCIDO)';
      } else if (lote.fechaVencimiento!.isBefore(now.add(const Duration(days: 30)))) {
        estadoVencimiento = ' (POR VENCER)';
      }
    }

    return ListTile(
      dense: true,
      title: Text('Lote: ${lote.numeroLote ?? "N/A"}'),
      subtitle: Text(
        'Cant: ${lote.cantidadActual}${estadoVencimiento}' +
        (lote.fechaVencimiento != null ? ' - Vence: ${dateFormat.format(lote.fechaVencimiento!)}' : ''),
      ),
      trailing: lote.fechaVencimiento != null && lote.fechaVencimiento!.isBefore(DateTime.now())
          ? const Icon(Icons.error, color: Colors.red, size: 16)
          : null,
    );
  }

  Widget _buildAlertas(InventarioState state) {
    if (state.productosCriticos.isEmpty && state.lotesPorVencer.isEmpty && state.lotesVencidos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text('No hay alertas', style: TextStyle(fontSize: 18)),
            Text('El inventario está en orden'),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (state.productosCriticos.isNotEmpty) ...[
          _buildSeccionTitulo('Productos con Stock Bajo', Colors.orange),
          ...state.productosCriticos.map((p) => ListTile(
                leading: const Icon(Icons.trending_down, color: Colors.orange),
                title: Text(p.nombre),
                subtitle: Text('Stock mínimo: ${p.stockMinimo}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              )),
          const SizedBox(height: 16),
        ],
        if (state.lotesPorVencer.isNotEmpty) ...[
          _buildSeccionTitulo('Lotes por Vencer (30 días)', Colors.amber),
          ...state.lotesPorVencer.map((l) => _buildLoteAlerta(l, Colors.amber)),
          const SizedBox(height: 16),
        ],
        if (state.lotesVencidos.isNotEmpty) ...[
          _buildSeccionTitulo('Lotes Vencidos', Colors.red),
          ...state.lotesVencidos.map((l) => _buildLoteAlerta(l, Colors.red)),
        ],
      ],
    );
  }

  Widget _buildSeccionTitulo(String titulo, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(titulo, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildLoteAlerta(Lote lote, Color color) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final productoAsync = ref.watch(productoInfoProvider(lote.productoId));

    return productoAsync.when(
      data: (info) {
        final producto = info['producto'] as Producto?;
        return ListTile(
          leading: Icon(Icons.schedule, color: color),
          title: Text(producto?.nombre ?? 'Producto #${lote.productoId}'),
          subtitle: Text(
            'Lote: ${lote.numeroLote ?? "N/A"} - Cant: ${lote.cantidadActual}' +
            (lote.fechaVencimiento != null ? ' - Vence: ${dateFormat.format(lote.fechaVencimiento!)}' : ''),
          ),
          trailing: lote.cantidadActual > 0
              ? ElevatedButton(
                  onPressed: () {},
                  child: const Text('Aplicar'),
                )
              : const Chip(label: Text('Sin stock')),
        );
      },
      loading: () => const ListTile(title: Text('Cargando...')),
      error: (e, _) => ListTile(title: Text('Error: $e')),
    );
  }
}