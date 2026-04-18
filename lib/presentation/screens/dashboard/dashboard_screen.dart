import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/dashboard_provider.dart';
import '../../../data/datasources/database.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(dashboardProvider.notifier).load(),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(dashboardProvider.notifier).load(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildStatsRow(state),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildUltimasVentas(state)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildAlertas(state)),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'es_BO');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenido a FarmaFacil',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          dateFormat.format(now),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(DashboardState state) {
    final currencyFormat = NumberFormat.currency(symbol: 'Bs.', decimalDigits: 2);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Ventas Hoy',
                currencyFormat.format(state.ventasHoy),
                '${state.numVentasHoy} transacciones',
                Icons.today,
                Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Ventas Esta Semana',
                currencyFormat.format(state.ventasSemana),
                '${state.numVentasSemana} transacciones',
                Icons.date_range,
                Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Alertas Pendientes',
                '${state.alertasPendientes.length}',
                state.alertasPendientes.isEmpty
                    ? 'Sin alertas'
                    : 'Revisar inventario',
                Icons.warning,
                state.alertasPendientes.isEmpty ? Colors.grey : Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String titulo, String valor, String subtitulo, IconData icono, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icono, color: color),
                ),
                const SizedBox(width: 12),
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              valor,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitulo,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUltimasVentas(DashboardState state) {
    final dateFormat = DateFormat('dd/MM HH:mm');
    final currencyFormat = NumberFormat.currency(symbol: 'Bs.', decimalDigits: 2);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Últimas Ventas',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(),
            if (state.ultimasVentas.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text('No hay ventas aún'),
                ),
              )
            else
              ...state.ultimasVentas.map((venta) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: _getMetodoColor(venta.metodoPago).withOpacity(0.2),
                      child: Icon(
                        _getMetodoIcon(venta.metodoPago),
                        size: 16,
                        color: _getMetodoColor(venta.metodoPago),
                      ),
                    ),
                    title: Text('Venta #${venta.id}'),
                    subtitle: Text(dateFormat.format(venta.fechaHora)),
                    trailing: Text(
                      currencyFormat.format(venta.total),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertas(DashboardState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber, size: 20, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Alertas',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(),
            if (state.alertasPendientes.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, size: 40, color: Colors.green),
                      SizedBox(height: 8),
                      Text('Sin alertas', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            else
              ...state.alertasPendientes.take(5).map((alerta) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      _getAlertaIcon(alerta.tipo),
                      color: _getAlertaColor(alerta.tipo),
                    ),
                    title: Text(alerta.tipo),
                    subtitle: Text(
                      DateFormat('dd/MM').format(alerta.fechaCreacion),
                    ),
                    trailing: Chip(
                      label: Text(alerta.estado),
                      padding: EdgeInsets.zero,
                    ),
                  )),
          ],
        ),
      ),
    );
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

  IconData _getAlertaIcon(String tipo) {
    switch (tipo) {
      case 'stock_bajo':
        return Icons.trending_down;
      case 'por_vencer':
        return Icons.schedule;
      case 'vencido':
        return Icons.error;
      default:
        return Icons.warning;
    }
  }

  Color _getAlertaColor(String tipo) {
    switch (tipo) {
      case 'stock_bajo':
        return Colors.orange;
      case 'por_vencer':
        return Colors.amber;
      case 'vencido':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}