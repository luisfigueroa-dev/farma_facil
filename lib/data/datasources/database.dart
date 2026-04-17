import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 1, max: 50)();
  TextColumn get password => text()();
  TextColumn get rol => text()();
  TextColumn get email => text().nullable()();
}

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  IntColumn get padreId => integer().nullable().references(Categorias, #id)();
}

class Productos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 200)();
  TextColumn get principioActivo => text().nullable()();
  TextColumn get laboratorio => text().nullable()();
  TextColumn get presentacion => text().nullable()();
  TextColumn get codigoBarras => text().nullable()();
  BoolColumn get requiereReceta => boolean().withDefault(const Constant(false))();
  RealColumn get precioVenta => real()();
  IntColumn get stockMinimo => integer().withDefault(const Constant(0))();
  IntColumn get categoriaId => integer().nullable().references(Categorias, #id)();
}

class Lotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productoId => integer().references(Productos, #id)();
  TextColumn get numeroLote => text().nullable()();
  DateTimeColumn get fechaVencimiento => dateTime().nullable()();
  IntColumn get cantidadActual => integer()();
  RealColumn get costoUnitario => real().nullable()();
}

class Sintomas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
}

class ProductoSintomas extends Table {
  IntColumn get productoId => integer().references(Productos, #id)();
  IntColumn get sintomaId => integer().references(Sintomas, #id)();

  @override
  Set<Column> get primaryKey => {productoId, sintomaId};
}

class Clientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 200)();
  TextColumn get telefono => text().nullable()();
  TextColumn get nit => text().nullable()();
}

class Recetas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get numero => text().withLength(min: 1, max: 50)();
  TextColumn get paciente => text().withLength(min: 1, max: 200)();
  TextColumn get medico => text().nullable()();
  DateTimeColumn get fechaEmision => dateTime()();
  DateTimeColumn get fechaVencimiento => dateTime()();
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
}

class DetalleRecetas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recetaId => integer().references(Recetas, #id)();
  IntColumn get productoId => integer().references(Productos, #id)();
  IntColumn get cantidadAutorizada => integer()();
  IntColumn get cantidadDispensada => integer().withDefault(const Constant(0))();
}

class Ventas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  IntColumn get clienteId => integer().nullable().references(Clientes, #id)();
  DateTimeColumn get fechaHora => dateTime()();
  RealColumn get subtotal => real()();
  RealColumn get igv => real()();
  RealColumn get total => real()();
  TextColumn get metodoPago => text()();
  TextColumn get estado => text().withDefault(const Constant('completada'))();
}

class DetalleVentas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ventaId => integer().references(Ventas, #id)();
  IntColumn get loteId => integer().references(Lotes, #id)();
  IntColumn get cantidad => integer()();
  RealColumn get precioUnitario => real()();
}

class Alertas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tipo => text()();
  IntColumn get productoId => integer().references(Productos, #id)();
  IntColumn get loteId => integer().nullable().references(Lotes, #id)();
  DateTimeColumn get fechaCreacion => dateTime()();
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
}

class Configuraciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clave => text().unique()();
  TextColumn get valor => text()();
}

@DriftDatabase(tables: [
  Usuarios,
  Categorias,
  Productos,
  Lotes,
  Sintomas,
  ProductoSintomas,
  Clientes,
  Recetas,
  DetalleRecetas,
  Ventas,
  DetalleVentas,
  Alertas,
  Configuraciones,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _insertarDatosIniciales();
      },
    );
  }

  Future<void> _insertarDatosIniciales() async {
    await into(usuarios).insert(UsuariosCompanion.insert(
      username: 'admin',
      password: 'admin123',
      rol: 'administrador',
      email: const Value('admin@farmafacil.com'),
    ));

    await into(usuarios).insert(UsuariosCompanion.insert(
      username: 'cajero',
      password: 'cajero123',
      rol: 'cajero',
      email: const Value('cajero@farmafacil.com'),
    ));

    await into(configuraciones).insert(ConfiguracionesCompanion.insert(
      clave: 'nombre_farmacia',
      valor: 'FarmaFacil',
    ));
    await into(configuraciones).insert(ConfiguracionesCompanion.insert(
      clave: 'direccion',
      valor: 'Av. Principal #123',
    ));
    await into(configuraciones).insert(ConfiguracionesCompanion.insert(
      clave: 'nit',
      valor: '123456789',
    ));
    await into(configuraciones).insert(ConfiguracionesCompanion.insert(
      clave: 'telefono',
      valor: '12345678',
    ));
    await into(configuraciones).insert(ConfiguracionesCompanion.insert(
      clave: 'iva_porcentaje',
      valor: '13',
    ));

    final docsDir = await getApplicationDocumentsDirectory();
    await into(configuraciones).insert(ConfiguracionesCompanion.insert(
      clave: 'ruta_pdf',
      valor: p.join(docsDir.path, 'FarmaFacil'),
    ));

    await into(categorias).insert(CategoriasCompanion.insert(
      nombre: 'Analgésicos',
    ));
    await into(categorias).insert(CategoriasCompanion.insert(
      nombre: 'Antibióticos',
    ));
    await into(categorias).insert(CategoriasCompanion.insert(
      nombre: 'Vitaminas',
    ));
    await into(categorias).insert(CategoriasCompanion.insert(
      nombre: 'Cuidado Personal',
    ));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'farma_facil.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}