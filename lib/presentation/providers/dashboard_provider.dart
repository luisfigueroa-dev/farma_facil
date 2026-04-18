import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../data/datasources/database.dart';
import 'database_provider.dart';

class DashboardState {
  final double ventasHoy;
  final double ventasSemana;
  final int numVentasHoy;
  final int numVentasSemana;
  final List<Venta> ultimasVentas;
  final List<Producto> productosMasVendidos;
  final List<Alerta> alertasPendientes;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.ventasHoy = 0,
    this.ventasSemana = 0,
    this.numVentasHoy = 0,
    this.numVentasSemana = 0,
    this.ultimasVentas = const [],
    this.productosMasVendidos = const [],
    this.alertasPendientes = const [],
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    double? ventasHoy,
    double? ventasSemana,
    int? numVentasHoy,
    int? numVentasSemana,
    List<Venta>? ultimasVentas,
    List<Producto>? productosMasVendidos,
    List<Alerta>? alertasPendientes,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      ventasHoy: ventasHoy ?? this.ventasHoy,
      ventasSemana: ventasSemana ?? this.ventasSemana,
      numVentasHoy: numVentasHoy ?? this.numVentasHoy,
      numVentasSemana: numVentasSemana ?? this.numVentasSemana,
      ultimasVentas: ultimasVentas ?? this.ultimasVentas,
      productosMasVendidos: productosMasVendidos ?? this.productosMasVendidos,
      alertasPendientes: alertasPendientes ?? this.alertasPendientes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  final Ref ref;

  DashboardNotifier(this.ref) : super(const DashboardState(isLoading: true)) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(databaseProvider);

      final now = DateTime.now();
      final inicioDia = DateTime(now.year, now.month, now.day);
      final inicioSemana = inicioDia.subtract(Duration(days: now.weekday - 1));

      final ventasDelDia = await (db.select(db.ventas)
        ..where((t) => t.fechaHora.isBiggerOrEqualValue(inicioDia) & t.estado.equals('completada')))
        .get();

      final ventasDeSemana = await (db.select(db.ventas)
        ..where((t) => t.fechaHora.isBiggerOrEqualValue(inicioSemana) & t.estado.equals('completada')))
        .get();

      final ventasHoy = ventasDelDia.fold<double>(0, (sum, v) => sum + v.total);
      final ventasSemana = ventasDeSemana.fold<double>(0, (sum, v) => sum + v.total);

      final ultimasVentasQuery = db.select(db.ventas)
        ..orderBy([(t) => OrderingTerm.desc(t.fechaHora)])
        ..limit(5);
      final ultimasVentas = await ultimasVentasQuery.get();

      final alertasPendientes = await (db.select(db.alertas)
        ..where((t) => t.estado.equals('pendiente')))
        .get();

      final productos = await db.select(db.productos).get();

      state = state.copyWith(
        ventasHoy: ventasHoy,
        ventasSemana: ventasSemana,
        numVentasHoy: ventasDelDia.length,
        numVentasSemana: ventasDeSemana.length,
        ultimasVentas: ultimasVentas,
        productosMasVendidos: productos.take(5).toList(),
        alertasPendientes: alertasPendientes,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final dashboardProvider = StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(ref);
});