import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/database.dart';
import 'database_provider.dart';

class ResumenInventario {
  final int totalProductos;
  final int totalLotes;
  final int productosStockBajo;
  final int lotesPorVencer;
  final int lotesVencidos;

  const ResumenInventario({
    required this.totalProductos,
    required this.totalLotes,
    required this.productosStockBajo,
    required this.lotesPorVencer,
    required this.lotesVencidos,
  });
}

class InventarioState {
  final ResumenInventario? resumen;
  final List<Lote> lotes;
  final List<Producto> productosCriticos;
  final List<Lote> lotesPorVencer;
  final List<Lote> lotesVencidos;
  final bool isLoading;
  final String? error;
  final String filtro;

  const InventarioState({
    this.resumen,
    this.lotes = const [],
    this.productosCriticos = const [],
    this.lotesPorVencer = const [],
    this.lotesVencidos = const [],
    this.isLoading = false,
    this.error,
    this.filtro = 'todos',
  });

  InventarioState copyWith({
    ResumenInventario? resumen,
    List<Lote>? lotes,
    List<Producto>? productosCriticos,
    List<Lote>? lotesPorVencer,
    List<Lote>? lotesVencidos,
    bool? isLoading,
    String? error,
    String? filtro,
  }) {
    return InventarioState(
      resumen: resumen ?? this.resumen,
      lotes: lotes ?? this.lotes,
      productosCriticos: productosCriticos ?? this.productosCriticos,
      lotesPorVencer: lotesPorVencer ?? this.lotesPorVencer,
      lotesVencidos: lotesVencidos ?? this.lotesVencidos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filtro: filtro ?? this.filtro,
    );
  }
}

class InventarioNotifier extends StateNotifier<InventarioState> {
  final Ref ref;

  InventarioNotifier(this.ref) : super(const InventarioState(isLoading: true)) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(databaseProvider);

      final allLotes = await db.select(db.lotes).get();
      final allProductos = await db.select(db.productos).get();

      final now = DateTime.now();
      final treintaDias = now.add(const Duration(days: 30));

      final productosConStock = <int, int>{};
      for (final lote in allLotes) {
        productosConStock[lote.productoId] = (productosConStock[lote.productoId] ?? 0) + lote.cantidadActual;
      }

      final productosCriticos = allProductos.where((p) {
        final stock = productosConStock[p.id] ?? 0;
        return stock < p.stockMinimo;
      }).toList();

      final lotesPorVencer = allLotes.where((l) {
        if (l.fechaVencimiento == null) return false;
        return l.fechaVencimiento!.isAfter(now) && l.fechaVencimiento!.isBefore(treintaDias) && l.cantidadActual > 0;
      }).toList();

      final lotesVencidos = allLotes.where((l) {
        if (l.fechaVencimiento == null) return false;
        return l.fechaVencimiento!.isBefore(now) && l.cantidadActual > 0;
      }).toList();

      final resumen = ResumenInventario(
        totalProductos: allProductos.length,
        totalLotes: allLotes.length,
        productosStockBajo: productosCriticos.length,
        lotesPorVencer: lotesPorVencer.length,
        lotesVencidos: lotesVencidos.length,
      );

      state = state.copyWith(
        resumen: resumen,
        lotes: allLotes,
        productosCriticos: productosCriticos,
        lotesPorVencer: lotesPorVencer,
        lotesVencidos: lotesVencidos,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setFiltro(String filtro) {
    state = state.copyWith(filtro: filtro);
  }

  Future<Map<String, dynamic>> getProducto(int productoId) async {
    final db = ref.read(databaseProvider);
    final producto = await (db.select(db.productos)..where((t) => t.id.equals(productoId))).getSingleOrNull();
    final categoria = producto?.categoriaId != null
        ? await (db.select(db.categorias)..where((t) => t.id.equals(producto!.categoriaId!))).getSingleOrNull()
        : null;
    return {'producto': producto, 'categoria': categoria};
  }
}

final inventarioProvider = StateNotifierProvider<InventarioNotifier, InventarioState>((ref) {
  return InventarioNotifier(ref);
});

final productoInfoProvider = FutureProvider.family<Map<String, dynamic>, int>((ref, productoId) async {
  final db = ref.read(databaseProvider);
  final producto = await (db.select(db.productos)..where((t) => t.id.equals(productoId))).getSingleOrNull();
  final categoria = producto?.categoriaId != null
      ? await (db.select(db.categorias)..where((t) => t.id.equals(producto!.categoriaId!))).getSingleOrNull()
      : null;
  return {'producto': producto, 'categoria': categoria};
});

final lotesPorProductoProvider = FutureProvider.family<List<Lote>, int>((ref, productoId) async {
  final db = ref.read(databaseProvider);
  return (db.select(db.lotes)..where((t) => t.productoId.equals(productoId))).get();
});