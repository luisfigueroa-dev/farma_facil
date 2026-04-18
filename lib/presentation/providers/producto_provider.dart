import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/database.dart';
import 'database_provider.dart';

final productosProvider = FutureProvider<List<Producto>>((ref) async {
  final db = ref.read(databaseProvider);
  return db.select(db.productos).get();
});

final productosBusquedaProvider = FutureProvider.family<List<Producto>, String>((ref, query) async {
  final db = ref.read(databaseProvider);
  if (query.isEmpty) {
    return db.select(db.productos).get();
  }
  final lowerQuery = '%${query.toLowerCase()}%';
  return (db.select(db.productos)
    ..where((t) => t.nombre.lower().like(lowerQuery) | t.codigoBarras.lower().like(lowerQuery) | t.principioActivo.lower().like(lowerQuery)))
    .get();
});

final categoriasProvider = FutureProvider<List<Categoria>>((ref) async {
  final db = ref.read(databaseProvider);
  return db.select(db.categorias).get();
});

final productoByIdProvider = FutureProvider.family<Producto?, int>((ref, id) async {
  final db = ref.read(databaseProvider);
  return (db.select(db.productos)..where((t) => t.id.equals(id))).getSingleOrNull();
});

class ProductoNotifier extends StateNotifier<AsyncValue<List<Producto>>> {
  final Ref ref;

  ProductoNotifier(this.ref) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final db = ref.read(databaseProvider);
      final productos = await db.select(db.productos).get();
      state = AsyncValue.data(productos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<int?> crear({
    required String nombre,
    String? principioActivo,
    String? laboratorio,
    String? presentacion,
    String? codigoBarras,
    bool requiereReceta = false,
    required double precioVenta,
    int stockMinimo = 0,
    int? categoriaId,
  }) async {
    try {
      final db = ref.read(databaseProvider);
      final id = await db.into(db.productos).insert(
        ProductosCompanion.insert(
          nombre: nombre,
          principioActivo: Value(principioActivo),
          laboratorio: Value(laboratorio),
          presentacion: Value(presentacion),
          codigoBarras: Value(codigoBarras),
          requiereReceta: Value(requiereReceta),
          precioVenta: precioVenta,
          stockMinimo: Value(stockMinimo),
          categoriaId: Value(categoriaId),
        ),
      );
      await refresh();
      return id;
    } catch (e) {
      return null;
    }
  }

  Future<bool> actualizar({
    required int id,
    required String nombre,
    String? principioActivo,
    String? laboratorio,
    String? presentacion,
    String? codigoBarras,
    bool requiereReceta = false,
    required double precioVenta,
    int stockMinimo = 0,
    int? categoriaId,
  }) async {
    try {
      final db = ref.read(databaseProvider);
      await (db.update(db.productos)..where((t) => t.id.equals(id))).write(
        ProductosCompanion(
          nombre: Value(nombre),
          principioActivo: Value(principioActivo),
          laboratorio: Value(laboratorio),
          presentacion: Value(presentacion),
          codigoBarras: Value(codigoBarras),
          requiereReceta: Value(requiereReceta),
          precioVenta: Value(precioVenta),
          stockMinimo: Value(stockMinimo),
          categoriaId: Value(categoriaId),
        ),
      );
      await refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> eliminar(int id) async {
    try {
      final db = ref.read(databaseProvider);
      await (db.delete(db.productos)..where((t) => t.id.equals(id))).go();
      await refresh();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final productoNotifierProvider = StateNotifierProvider<ProductoNotifier, AsyncValue<List<Producto>>>((ref) {
  return ProductoNotifier(ref);
});

class CategoriaNotifier extends StateNotifier<AsyncValue<List<Categoria>>> {
  final Ref ref;

  CategoriaNotifier(this.ref) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final db = ref.read(databaseProvider);
      final categorias = await db.select(db.categorias).get();
      state = AsyncValue.data(categorias);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<int?> crear(String nombre, int? padreId) async {
    try {
      final db = ref.read(databaseProvider);
      final id = await db.into(db.categorias).insert(
        CategoriasCompanion.insert(
          nombre: nombre,
          padreId: Value(padreId),
        ),
      );
      await refresh();
      return id;
    } catch (e) {
      return null;
    }
  }

  Future<bool> eliminar(int id) async {
    try {
      final db = ref.read(databaseProvider);
      await (db.delete(db.categorias)..where((t) => t.id.equals(id))).go();
      await refresh();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final categoriaNotifierProvider = StateNotifierProvider<CategoriaNotifier, AsyncValue<List<Categoria>>>((ref) {
  return CategoriaNotifier(ref);
});