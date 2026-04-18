import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/database.dart';
import 'database_provider.dart';

final recetasProvider = FutureProvider<List<Receta>>((ref) async {
  final db = ref.read(databaseProvider);
  return (db.select(db.recetas)..orderBy([(t) => OrderingTerm.desc(t.fechaEmision)])).get();
});

final recetaByIdProvider = FutureProvider.family<Receta?, int>((ref, id) async {
  final db = ref.read(databaseProvider);
  return (db.select(db.recetas)..where((t) => t.id.equals(id))).getSingleOrNull();
});

final detallesRecetaProvider = FutureProvider.family<List<DetalleReceta>, int>((ref, recetaId) async {
  final db = ref.read(databaseProvider);
  return (db.select(db.detalleRecetas)..where((t) => t.recetaId.equals(recetaId))).get();
});

class RecetaNotifier extends StateNotifier<AsyncValue<List<Receta>>> {
  final Ref ref;

  RecetaNotifier(this.ref) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final db = ref.read(databaseProvider);
      final recetas = await (db.select(db.recetas)..orderBy([(t) => OrderingTerm.desc(t.fechaEmision)])).get();
      state = AsyncValue.data(recetas);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<int?> crear({
    required String numero,
    required String paciente,
    String? medico,
    required DateTime fechaEmision,
    required DateTime fechaVencimiento,
    required List<Map<String, dynamic>> detalles,
  }) async {
    try {
      final db = ref.read(databaseProvider);
      final recetaId = await db.transaction(() async {
        final id = await db.into(db.recetas).insert(
          RecetasCompanion.insert(
            numero: numero,
            paciente: paciente,
            medico: Value(medico),
            fechaEmision: fechaEmision,
            fechaVencimiento: fechaVencimiento,
          ),
        );

        for (final detalle in detalles) {
          await db.into(db.detalleRecetas).insert(
            DetalleRecetasCompanion.insert(
              recetaId: id,
              productoId: detalle['productoId'] as int,
              cantidadAutorizada: detalle['cantidad'] as int,
            ),
          );
        }

        return id;
      });

      await refresh();
      return recetaId;
    } catch (e) {
      return null;
    }
  }

  Future<bool> dispensar(int recetaId, Map<int, int> dispensaciones) async {
    try {
      final db = ref.read(databaseProvider);

      await db.transaction(() async {
        for (final entry in dispensaciones.entries) {
          final detalleReceta = await (db.select(db.detalleRecetas)
            ..where((t) => t.id.equals(entry.key)))
            .getSingleOrNull();

          if (detalleReceta != null) {
            await (db.update(db.detalleRecetas)..where((t) => t.id.equals(entry.key)))
                .write(DetalleRecetasCompanion(
              cantidadDispensada: Value(detalleReceta.cantidadDispensada + entry.value),
            ));
          }
        }

        final detalles = await (db.select(db.detalleRecetas)..where((t) => t.recetaId.equals(recetaId))).get();
        final todosDispensados = detalles.every((d) => d.cantidadDispensada >= d.cantidadAutorizada);

        if (todosDispensados) {
          await (db.update(db.recetas)..where((t) => t.id.equals(recetaId)))
              .write(RecetasCompanion(estado: const Value('dispensada')));
        }
      });

      await refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> eliminar(int id) async {
    try {
      final db = ref.read(databaseProvider);
      await (db.delete(db.detalleRecetas)..where((t) => t.recetaId.equals(id))).go();
      await (db.delete(db.recetas)..where((t) => t.id.equals(id))).go();
      await refresh();
      return true;
    } catch (e) {
      return false;
    }
  }
}

final recetaNotifierProvider = StateNotifierProvider<RecetaNotifier, AsyncValue<List<Receta>>>((ref) {
  return RecetaNotifier(ref);
});

final productosSustitutosProvider = FutureProvider.family<List<Producto>, String>((ref, principioActivo) async {
  if (principioActivo.isEmpty) return [];
  final db = ref.read(databaseProvider);
  final lowerQuery = '%${principioActivo.toLowerCase()}%';
  return (db.select(db.productos)..where((t) => t.principioActivo.lower().like(lowerQuery))).get();
});

final productosPorSintomaProvider = FutureProvider.family<List<Producto>, int>((ref, sintomaId) async {
  final db = ref.read(databaseProvider);
  final productoSintomas = await (db.select(db.productoSintomas)..where((t) => t.sintomaId.equals(sintomaId))).get();
  final productoIds = productoSintomas.map((ps) => ps.productoId).toList();
  if (productoIds.isEmpty) return [];
  return (db.select(db.productos)..where((t) => t.id.isIn(productoIds))).get();
});

final sintomasProvider = FutureProvider<List<Sintoma>>((ref) async {
  final db = ref.read(databaseProvider);
  return db.select(db.sintomas).get();
});

final productoByIdProvider = FutureProvider.family<Producto?, int>((ref, id) async {
  final db = ref.read(databaseProvider);
  return (db.select(db.productos)..where((t) => t.id.equals(id))).getSingleOrNull();
});