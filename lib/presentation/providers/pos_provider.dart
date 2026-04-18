import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/venta.dart';
import '../../../data/datasources/database.dart' as db;
import 'database_provider.dart';

class CarritoItem {
  final int productoId;
  final String nombreProducto;
  final String? presentacion;
  final int loteId;
  final String? numeroLote;
  final int cantidad;
  final double precioUnitario;

  const CarritoItem({
    required this.productoId,
    required this.nombreProducto,
    this.presentacion,
    required this.loteId,
    this.numeroLote,
    required this.cantidad,
    required this.precioUnitario,
  });

  double get total => cantidad * precioUnitario;

  CarritoItem copyWith({int? cantidad}) {
    return CarritoItem(
      productoId: productoId,
      nombreProducto: nombreProducto,
      presentacion: presentacion,
      loteId: loteId,
      numeroLote: numeroLote,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario,
    );
  }
}

class CarritoState {
  final List<CarritoItem> items;
  final int? clienteId;
  final MetodoPago metodoPago;

  const CarritoState({
    this.items = const [],
    this.clienteId,
    this.metodoPago = MetodoPago.efectivo,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get igv => subtotal * 0.13;
  double get total => subtotal + igv;
  int get cantidadItems => items.fold(0, (sum, item) => sum + item.cantidad);

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  CarritoState copyWith({
    List<CarritoItem>? items,
    int? clienteId,
    MetodoPago? metodoPago,
  }) {
    return CarritoState(
      items: items ?? this.items,
      clienteId: clienteId ?? this.clienteId,
      metodoPago: metodoPago ?? this.metodoPago,
    );
  }
}

class CarritoNotifier extends StateNotifier<CarritoState> {
  final Ref ref;

  CarritoNotifier(this.ref) : super(const CarritoState());

  void agregarProducto({
    required int productoId,
    required String nombreProducto,
    String? presentacion,
    required int loteId,
    String? numeroLote,
    required int cantidad,
    required double precioUnitario,
  }) {
    final existingIndex = state.items.indexWhere(
      (item) => item.productoId == productoId && item.loteId == loteId,
    );

    if (existingIndex >= 0) {
      final updatedItems = List<CarritoItem>.from(state.items);
      final existing = updatedItems[existingIndex];
      updatedItems[existingIndex] = existing.copyWith(
        cantidad: existing.cantidad + cantidad,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,
          CarritoItem(
            productoId: productoId,
            nombreProducto: nombreProducto,
            presentacion: presentacion,
            loteId: loteId,
            numeroLote: numeroLote,
            cantidad: cantidad,
            precioUnitario: precioUnitario,
          ),
        ],
      );
    }
  }

  void actualizarCantidad(int index, int cantidad) {
    if (cantidad <= 0) {
      eliminarItem(index);
      return;
    }
    final updatedItems = List<CarritoItem>.from(state.items);
    updatedItems[index] = updatedItems[index].copyWith(cantidad: cantidad);
    state = state.copyWith(items: updatedItems);
  }

  void eliminarItem(int index) {
    final updatedItems = List<CarritoItem>.from(state.items);
    updatedItems.removeAt(index);
    state = state.copyWith(items: updatedItems);
  }

  void setMetodoPago(MetodoPago metodo) {
    state = state.copyWith(metodoPago: metodo);
  }

  void setCliente(int? clienteId) {
    state = state.copyWith(clienteId: clienteId);
  }

  void limpiar() {
    state = const CarritoState();
  }

  Future<int?> finalizarVenta(int usuarioId) async {
    if (state.isEmpty) return null;

    final dbInstance = ref.read(databaseProvider);

    try {
      final ventaId = await dbInstance.transaction(() async {
        final ventaId = await dbInstance.into(dbInstance.ventas).insert(
          db.VentasCompanion.insert(
            usuarioId: usuarioId,
            clienteId: Value(state.clienteId),
            fechaHora: DateTime.now(),
            subtotal: state.subtotal,
            igv: state.igv,
            total: state.total,
            metodoPago: state.metodoPago.name,
          ),
        );

        for (final item in state.items) {
          await dbInstance.into(dbInstance.detalleVentas).insert(
            db.DetalleVentasCompanion.insert(
              ventaId: ventaId,
              loteId: item.loteId,
              cantidad: item.cantidad,
              precioUnitario: item.precioUnitario,
            ),
          );

          final lote = await (dbInstance.select(dbInstance.lotes)
            ..where((t) => t.id.equals(item.loteId)))
            .getSingle();

          await (dbInstance.update(dbInstance.lotes)..where((t) => t.id.equals(item.loteId)))
            .write(db.LotesCompanion(
              cantidadActual: Value(lote.cantidadActual - item.cantidad),
            ));
        }

        return ventaId;
      });

      state = const CarritoState();
      return ventaId;
    } catch (e) {
      return null;
    }
  }
}

final carritoProvider = StateNotifierProvider<CarritoNotifier, CarritoState>((ref) {
  return CarritoNotifier(ref);
});

final productosBusquedaProvider = FutureProvider.family<List<db.Producto>, String>((ref, query) async {
  if (query.isEmpty) return [];
  
  final dbInstance = ref.read(databaseProvider);
  final lowerQuery = '%${query.toLowerCase()}%';
  
  final results = await (dbInstance.select(dbInstance.productos)
    ..where((t) => t.nombre.lower().like(lowerQuery) | t.codigoBarras.lower().like(lowerQuery) | t.principioActivo.lower().like(lowerQuery)))
    .get();
  
  return results;
});

final lotesPorProductoProvider = FutureProvider.family<List<db.Lote>, int>((ref, productoId) async {
  final dbInstance = ref.read(databaseProvider);
  
  final results = await (dbInstance.select(dbInstance.lotes)
    ..where((t) => t.productoId.equals(productoId) & t.cantidadActual.isBiggerThanValue(0)))
    .get();
  
  return results;
});