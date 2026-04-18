import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/database.dart';
import 'database_provider.dart';

class ReporteVenta {
  final DateTime fecha;
  final int cantidadVentas;
  final double totalVentas;

  ReporteVenta({
    required this.fecha,
    required this.cantidadVentas,
    required this.totalVentas,
  });
}

class ReporteProducto {
  final Producto producto;
  final int cantidadVendida;
  final double totalVendido;

  ReporteProducto({
    required this.producto,
    required this.cantidadVendida,
    required this.totalVendido,
  });
}

class ReportesState {
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final List<ReporteVenta> ventasPorFecha;
  final List<ReporteProducto> productosMasVendidos;
  final Map<String, double> ventasPorMetodo;
  final double totalVentas;
  final double promedioVenta;
  final bool isLoading;
  final String? error;

  ReportesState({
    required this.fechaInicio,
    required this.fechaFin,
    this.ventasPorFecha = const [],
    this.productosMasVendidos = const [],
    this.ventasPorMetodo = const {},
    this.totalVentas = 0,
    this.promedioVenta = 0,
    this.isLoading = false,
    this.error,
  });

  ReportesState copyWith({
    DateTime? fechaInicio,
    DateTime? fechaFin,
    List<ReporteVenta>? ventasPorFecha,
    List<ReporteProducto>? productosMasVendidos,
    Map<String, double>? ventasPorMetodo,
    double? totalVentas,
    double? promedioVenta,
    bool? isLoading,
    String? error,
  }) {
    return ReportesState(
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      ventasPorFecha: ventasPorFecha ?? this.ventasPorFecha,
      productosMasVendidos: productosMasVendidos ?? this.productosMasVendidos,
      ventasPorMetodo: ventasPorMetodo ?? this.ventasPorMetodo,
      totalVentas: totalVentas ?? this.totalVentas,
      promedioVenta: promedioVenta ?? this.promedioVenta,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ReportesNotifier extends StateNotifier<ReportesState> {
  final Ref ref;

  ReportesNotifier(this.ref) : super(ReportesState(
    fechaInicio: DateTime.now().subtract(const Duration(days: 30)),
    fechaFin: DateTime.now(),
  )) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(databaseProvider);

      final ventas = await (db.select(db.ventas)
        ..where((t) => t.fechaHora.isBiggerOrEqualValue(state.fechaInicio) & 
                       t.fechaHora.isSmallerOrEqualValue(state.fechaFin) &
                       t.estado.equals('completada')))
        .get();

      final Map<String, double> ventasMetodo = {};
      double total = 0;
      for (final v in ventas) {
        ventasMetodo[v.metodoPago] = (ventasMetodo[v.metodoPago] ?? 0) + v.total;
        total += v.total;
      }

      final Map<DateTime, ReporteVenta> ventasAgrupadas = {};
      for (final v in ventas) {
        final fecha = DateTime(v.fechaHora.year, v.fechaHora.month, v.fechaHora.day);
        if (ventasAgrupadas.containsKey(fecha)) {
          final existing = ventasAgrupadas[fecha]!;
          ventasAgrupadas[fecha] = ReporteVenta(
            fecha: fecha,
            cantidadVentas: existing.cantidadVentas + 1,
            totalVentas: existing.totalVentas + v.total,
          );
        } else {
          ventasAgrupadas[fecha] = ReporteVenta(
            fecha: fecha,
            cantidadVentas: 1,
            totalVentas: v.total,
          );
        }
      }

      final Map<int, int> cantidadPorProducto = {};
      final Map<int, double> totalPorProducto = {};

      for (final venta in ventas) {
        final detalles = await (db.select(db.detalleVentas)
          ..where((t) => t.ventaId.equals(venta.id)))
          .get();

        for (final detalle in detalles) {
          cantidadPorProducto[detalle.loteId] = (cantidadPorProducto[detalle.loteId] ?? 0) + detalle.cantidad;
          totalPorProducto[detalle.loteId] = (totalPorProducto[detalle.loteId] ?? 0) + (detalle.cantidad * detalle.precioUnitario);
        }
      }

      final productos = await db.select(db.productos).get();
      final Map<int, Producto> productoMap = {for (var p in productos) p.id: p};

      final Map<int, int> cantidadPorProductoId = {};
      final Map<int, double> totalPorProductoId = {};

      for (final venta in ventas) {
        final detalles = await (db.select(db.detalleVentas)
          ..where((t) => t.ventaId.equals(venta.id)))
          .get();

        for (final detalle in detalles) {
          final lote = await (db.select(db.lotes)
            ..where((t) => t.id.equals(detalle.loteId)))
            .getSingleOrNull();
          
          if (lote != null) {
            cantidadPorProductoId[lote.productoId] = (cantidadPorProductoId[lote.productoId] ?? 0) + detalle.cantidad;
            totalPorProductoId[lote.productoId] = (totalPorProductoId[lote.productoId] ?? 0) + (detalle.cantidad * detalle.precioUnitario);
          }
        }
      }

      final productosTop = cantidadPorProductoId.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      
      final top5 = productosTop.take(5).map((entry) {
        final producto = productoMap[entry.key];
        return ReporteProducto(
          producto: producto ?? Producto(
            id: 0,
            nombre: 'Producto #${entry.key}',
            precioVenta: 0,
            requiereReceta: false,
            stockMinimo: 0,
          ),
          cantidadVendida: entry.value,
          totalVendido: totalPorProductoId[entry.key] ?? 0,
        );
      }).toList();

      state = state.copyWith(
        ventasPorFecha: ventasAgrupadas.values.toList()..sort((a, b) => a.fecha.compareTo(b.fecha)),
        productosMasVendidos: top5,
        ventasPorMetodo: ventasMetodo,
        totalVentas: total,
        promedioVenta: ventas.isEmpty ? 0 : total / ventas.length,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setRangoFechas(DateTime inicio, DateTime fin) {
    state = state.copyWith(fechaInicio: inicio, fechaFin: fin);
    load();
  }
}

final reportesProvider = StateNotifierProvider<ReportesNotifier, ReportesState>((ref) {
  return ReportesNotifier(ref);
});