// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
      'rol', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, username, password, rol, email];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(Insertable<Usuario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String username;
  final String password;
  final String rol;
  final String? email;
  const Usuario(
      {required this.id,
      required this.username,
      required this.password,
      required this.rol,
      this.email});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['rol'] = Variable<String>(rol);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      rol: Value(rol),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      rol: serializer.fromJson<String>(json['rol']),
      email: serializer.fromJson<String?>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'rol': serializer.toJson<String>(rol),
      'email': serializer.toJson<String?>(email),
    };
  }

  Usuario copyWith(
          {int? id,
          String? username,
          String? password,
          String? rol,
          Value<String?> email = const Value.absent()}) =>
      Usuario(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        rol: rol ?? this.rol,
        email: email.present ? email.value : this.email,
      );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      rol: data.rol.present ? data.rol.value : this.rol,
      email: data.email.present ? data.email.value : this.email,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('rol: $rol, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, rol, email);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.rol == this.rol &&
          other.email == this.email);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String> rol;
  final Value<String?> email;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.rol = const Value.absent(),
    this.email = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    required String rol,
    this.email = const Value.absent(),
  })  : username = Value(username),
        password = Value(password),
        rol = Value(rol);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? rol,
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (rol != null) 'rol': rol,
      if (email != null) 'email': email,
    });
  }

  UsuariosCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<String>? rol,
      Value<String?>? email}) {
    return UsuariosCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      rol: rol ?? this.rol,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('rol: $rol, ')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _padreIdMeta =
      const VerificationMeta('padreId');
  @override
  late final GeneratedColumn<int> padreId = GeneratedColumn<int>(
      'padre_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categorias (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, nombre, padreId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(Insertable<Categoria> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('padre_id')) {
      context.handle(_padreIdMeta,
          padreId.isAcceptableOrUnknown(data['padre_id']!, _padreIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      padreId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}padre_id']),
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String nombre;
  final int? padreId;
  const Categoria({required this.id, required this.nombre, this.padreId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || padreId != null) {
      map['padre_id'] = Variable<int>(padreId);
    }
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      padreId: padreId == null && nullToAbsent
          ? const Value.absent()
          : Value(padreId),
    );
  }

  factory Categoria.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      padreId: serializer.fromJson<int?>(json['padreId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'padreId': serializer.toJson<int?>(padreId),
    };
  }

  Categoria copyWith(
          {int? id,
          String? nombre,
          Value<int?> padreId = const Value.absent()}) =>
      Categoria(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        padreId: padreId.present ? padreId.value : this.padreId,
      );
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      padreId: data.padreId.present ? data.padreId.value : this.padreId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('padreId: $padreId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, padreId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.padreId == this.padreId);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<int?> padreId;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.padreId = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.padreId = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Categoria> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? padreId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (padreId != null) 'padre_id': padreId,
    });
  }

  CategoriasCompanion copyWith(
      {Value<int>? id, Value<String>? nombre, Value<int?>? padreId}) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      padreId: padreId ?? this.padreId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (padreId.present) {
      map['padre_id'] = Variable<int>(padreId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('padreId: $padreId')
          ..write(')'))
        .toString();
  }
}

class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _principioActivoMeta =
      const VerificationMeta('principioActivo');
  @override
  late final GeneratedColumn<String> principioActivo = GeneratedColumn<String>(
      'principio_activo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _laboratorioMeta =
      const VerificationMeta('laboratorio');
  @override
  late final GeneratedColumn<String> laboratorio = GeneratedColumn<String>(
      'laboratorio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _presentacionMeta =
      const VerificationMeta('presentacion');
  @override
  late final GeneratedColumn<String> presentacion = GeneratedColumn<String>(
      'presentacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codigoBarrasMeta =
      const VerificationMeta('codigoBarras');
  @override
  late final GeneratedColumn<String> codigoBarras = GeneratedColumn<String>(
      'codigo_barras', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _requiereRecetaMeta =
      const VerificationMeta('requiereReceta');
  @override
  late final GeneratedColumn<bool> requiereReceta = GeneratedColumn<bool>(
      'requiere_receta', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("requiere_receta" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _precioVentaMeta =
      const VerificationMeta('precioVenta');
  @override
  late final GeneratedColumn<double> precioVenta = GeneratedColumn<double>(
      'precio_venta', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stockMinimoMeta =
      const VerificationMeta('stockMinimo');
  @override
  late final GeneratedColumn<int> stockMinimo = GeneratedColumn<int>(
      'stock_minimo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _categoriaIdMeta =
      const VerificationMeta('categoriaId');
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
      'categoria_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categorias (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nombre,
        principioActivo,
        laboratorio,
        presentacion,
        codigoBarras,
        requiereReceta,
        precioVenta,
        stockMinimo,
        categoriaId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'productos';
  @override
  VerificationContext validateIntegrity(Insertable<Producto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('principio_activo')) {
      context.handle(
          _principioActivoMeta,
          principioActivo.isAcceptableOrUnknown(
              data['principio_activo']!, _principioActivoMeta));
    }
    if (data.containsKey('laboratorio')) {
      context.handle(
          _laboratorioMeta,
          laboratorio.isAcceptableOrUnknown(
              data['laboratorio']!, _laboratorioMeta));
    }
    if (data.containsKey('presentacion')) {
      context.handle(
          _presentacionMeta,
          presentacion.isAcceptableOrUnknown(
              data['presentacion']!, _presentacionMeta));
    }
    if (data.containsKey('codigo_barras')) {
      context.handle(
          _codigoBarrasMeta,
          codigoBarras.isAcceptableOrUnknown(
              data['codigo_barras']!, _codigoBarrasMeta));
    }
    if (data.containsKey('requiere_receta')) {
      context.handle(
          _requiereRecetaMeta,
          requiereReceta.isAcceptableOrUnknown(
              data['requiere_receta']!, _requiereRecetaMeta));
    }
    if (data.containsKey('precio_venta')) {
      context.handle(
          _precioVentaMeta,
          precioVenta.isAcceptableOrUnknown(
              data['precio_venta']!, _precioVentaMeta));
    } else if (isInserting) {
      context.missing(_precioVentaMeta);
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
          _stockMinimoMeta,
          stockMinimo.isAcceptableOrUnknown(
              data['stock_minimo']!, _stockMinimoMeta));
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
          _categoriaIdMeta,
          categoriaId.isAcceptableOrUnknown(
              data['categoria_id']!, _categoriaIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      principioActivo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}principio_activo']),
      laboratorio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}laboratorio']),
      presentacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}presentacion']),
      codigoBarras: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo_barras']),
      requiereReceta: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}requiere_receta'])!,
      precioVenta: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}precio_venta'])!,
      stockMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_minimo'])!,
      categoriaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}categoria_id']),
    );
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(attachedDatabase, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final int id;
  final String nombre;
  final String? principioActivo;
  final String? laboratorio;
  final String? presentacion;
  final String? codigoBarras;
  final bool requiereReceta;
  final double precioVenta;
  final int stockMinimo;
  final int? categoriaId;
  const Producto(
      {required this.id,
      required this.nombre,
      this.principioActivo,
      this.laboratorio,
      this.presentacion,
      this.codigoBarras,
      required this.requiereReceta,
      required this.precioVenta,
      required this.stockMinimo,
      this.categoriaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || principioActivo != null) {
      map['principio_activo'] = Variable<String>(principioActivo);
    }
    if (!nullToAbsent || laboratorio != null) {
      map['laboratorio'] = Variable<String>(laboratorio);
    }
    if (!nullToAbsent || presentacion != null) {
      map['presentacion'] = Variable<String>(presentacion);
    }
    if (!nullToAbsent || codigoBarras != null) {
      map['codigo_barras'] = Variable<String>(codigoBarras);
    }
    map['requiere_receta'] = Variable<bool>(requiereReceta);
    map['precio_venta'] = Variable<double>(precioVenta);
    map['stock_minimo'] = Variable<int>(stockMinimo);
    if (!nullToAbsent || categoriaId != null) {
      map['categoria_id'] = Variable<int>(categoriaId);
    }
    return map;
  }

  ProductosCompanion toCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      principioActivo: principioActivo == null && nullToAbsent
          ? const Value.absent()
          : Value(principioActivo),
      laboratorio: laboratorio == null && nullToAbsent
          ? const Value.absent()
          : Value(laboratorio),
      presentacion: presentacion == null && nullToAbsent
          ? const Value.absent()
          : Value(presentacion),
      codigoBarras: codigoBarras == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoBarras),
      requiereReceta: Value(requiereReceta),
      precioVenta: Value(precioVenta),
      stockMinimo: Value(stockMinimo),
      categoriaId: categoriaId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaId),
    );
  }

  factory Producto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      principioActivo: serializer.fromJson<String?>(json['principioActivo']),
      laboratorio: serializer.fromJson<String?>(json['laboratorio']),
      presentacion: serializer.fromJson<String?>(json['presentacion']),
      codigoBarras: serializer.fromJson<String?>(json['codigoBarras']),
      requiereReceta: serializer.fromJson<bool>(json['requiereReceta']),
      precioVenta: serializer.fromJson<double>(json['precioVenta']),
      stockMinimo: serializer.fromJson<int>(json['stockMinimo']),
      categoriaId: serializer.fromJson<int?>(json['categoriaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'principioActivo': serializer.toJson<String?>(principioActivo),
      'laboratorio': serializer.toJson<String?>(laboratorio),
      'presentacion': serializer.toJson<String?>(presentacion),
      'codigoBarras': serializer.toJson<String?>(codigoBarras),
      'requiereReceta': serializer.toJson<bool>(requiereReceta),
      'precioVenta': serializer.toJson<double>(precioVenta),
      'stockMinimo': serializer.toJson<int>(stockMinimo),
      'categoriaId': serializer.toJson<int?>(categoriaId),
    };
  }

  Producto copyWith(
          {int? id,
          String? nombre,
          Value<String?> principioActivo = const Value.absent(),
          Value<String?> laboratorio = const Value.absent(),
          Value<String?> presentacion = const Value.absent(),
          Value<String?> codigoBarras = const Value.absent(),
          bool? requiereReceta,
          double? precioVenta,
          int? stockMinimo,
          Value<int?> categoriaId = const Value.absent()}) =>
      Producto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        principioActivo: principioActivo.present
            ? principioActivo.value
            : this.principioActivo,
        laboratorio: laboratorio.present ? laboratorio.value : this.laboratorio,
        presentacion:
            presentacion.present ? presentacion.value : this.presentacion,
        codigoBarras:
            codigoBarras.present ? codigoBarras.value : this.codigoBarras,
        requiereReceta: requiereReceta ?? this.requiereReceta,
        precioVenta: precioVenta ?? this.precioVenta,
        stockMinimo: stockMinimo ?? this.stockMinimo,
        categoriaId: categoriaId.present ? categoriaId.value : this.categoriaId,
      );
  Producto copyWithCompanion(ProductosCompanion data) {
    return Producto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      principioActivo: data.principioActivo.present
          ? data.principioActivo.value
          : this.principioActivo,
      laboratorio:
          data.laboratorio.present ? data.laboratorio.value : this.laboratorio,
      presentacion: data.presentacion.present
          ? data.presentacion.value
          : this.presentacion,
      codigoBarras: data.codigoBarras.present
          ? data.codigoBarras.value
          : this.codigoBarras,
      requiereReceta: data.requiereReceta.present
          ? data.requiereReceta.value
          : this.requiereReceta,
      precioVenta:
          data.precioVenta.present ? data.precioVenta.value : this.precioVenta,
      stockMinimo:
          data.stockMinimo.present ? data.stockMinimo.value : this.stockMinimo,
      categoriaId:
          data.categoriaId.present ? data.categoriaId.value : this.categoriaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('principioActivo: $principioActivo, ')
          ..write('laboratorio: $laboratorio, ')
          ..write('presentacion: $presentacion, ')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('requiereReceta: $requiereReceta, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('categoriaId: $categoriaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nombre,
      principioActivo,
      laboratorio,
      presentacion,
      codigoBarras,
      requiereReceta,
      precioVenta,
      stockMinimo,
      categoriaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.principioActivo == this.principioActivo &&
          other.laboratorio == this.laboratorio &&
          other.presentacion == this.presentacion &&
          other.codigoBarras == this.codigoBarras &&
          other.requiereReceta == this.requiereReceta &&
          other.precioVenta == this.precioVenta &&
          other.stockMinimo == this.stockMinimo &&
          other.categoriaId == this.categoriaId);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> principioActivo;
  final Value<String?> laboratorio;
  final Value<String?> presentacion;
  final Value<String?> codigoBarras;
  final Value<bool> requiereReceta;
  final Value<double> precioVenta;
  final Value<int> stockMinimo;
  final Value<int?> categoriaId;
  const ProductosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.principioActivo = const Value.absent(),
    this.laboratorio = const Value.absent(),
    this.presentacion = const Value.absent(),
    this.codigoBarras = const Value.absent(),
    this.requiereReceta = const Value.absent(),
    this.precioVenta = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.categoriaId = const Value.absent(),
  });
  ProductosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.principioActivo = const Value.absent(),
    this.laboratorio = const Value.absent(),
    this.presentacion = const Value.absent(),
    this.codigoBarras = const Value.absent(),
    this.requiereReceta = const Value.absent(),
    required double precioVenta,
    this.stockMinimo = const Value.absent(),
    this.categoriaId = const Value.absent(),
  })  : nombre = Value(nombre),
        precioVenta = Value(precioVenta);
  static Insertable<Producto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? principioActivo,
    Expression<String>? laboratorio,
    Expression<String>? presentacion,
    Expression<String>? codigoBarras,
    Expression<bool>? requiereReceta,
    Expression<double>? precioVenta,
    Expression<int>? stockMinimo,
    Expression<int>? categoriaId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (principioActivo != null) 'principio_activo': principioActivo,
      if (laboratorio != null) 'laboratorio': laboratorio,
      if (presentacion != null) 'presentacion': presentacion,
      if (codigoBarras != null) 'codigo_barras': codigoBarras,
      if (requiereReceta != null) 'requiere_receta': requiereReceta,
      if (precioVenta != null) 'precio_venta': precioVenta,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
      if (categoriaId != null) 'categoria_id': categoriaId,
    });
  }

  ProductosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String?>? principioActivo,
      Value<String?>? laboratorio,
      Value<String?>? presentacion,
      Value<String?>? codigoBarras,
      Value<bool>? requiereReceta,
      Value<double>? precioVenta,
      Value<int>? stockMinimo,
      Value<int?>? categoriaId}) {
    return ProductosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      principioActivo: principioActivo ?? this.principioActivo,
      laboratorio: laboratorio ?? this.laboratorio,
      presentacion: presentacion ?? this.presentacion,
      codigoBarras: codigoBarras ?? this.codigoBarras,
      requiereReceta: requiereReceta ?? this.requiereReceta,
      precioVenta: precioVenta ?? this.precioVenta,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      categoriaId: categoriaId ?? this.categoriaId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (principioActivo.present) {
      map['principio_activo'] = Variable<String>(principioActivo.value);
    }
    if (laboratorio.present) {
      map['laboratorio'] = Variable<String>(laboratorio.value);
    }
    if (presentacion.present) {
      map['presentacion'] = Variable<String>(presentacion.value);
    }
    if (codigoBarras.present) {
      map['codigo_barras'] = Variable<String>(codigoBarras.value);
    }
    if (requiereReceta.present) {
      map['requiere_receta'] = Variable<bool>(requiereReceta.value);
    }
    if (precioVenta.present) {
      map['precio_venta'] = Variable<double>(precioVenta.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<int>(stockMinimo.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('principioActivo: $principioActivo, ')
          ..write('laboratorio: $laboratorio, ')
          ..write('presentacion: $presentacion, ')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('requiereReceta: $requiereReceta, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('categoriaId: $categoriaId')
          ..write(')'))
        .toString();
  }
}

class $LotesTable extends Lotes with TableInfo<$LotesTable, Lote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productoIdMeta =
      const VerificationMeta('productoId');
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
      'producto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES productos (id)'));
  static const VerificationMeta _numeroLoteMeta =
      const VerificationMeta('numeroLote');
  @override
  late final GeneratedColumn<String> numeroLote = GeneratedColumn<String>(
      'numero_lote', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaVencimientoMeta =
      const VerificationMeta('fechaVencimiento');
  @override
  late final GeneratedColumn<DateTime> fechaVencimiento =
      GeneratedColumn<DateTime>('fecha_vencimiento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _cantidadActualMeta =
      const VerificationMeta('cantidadActual');
  @override
  late final GeneratedColumn<int> cantidadActual = GeneratedColumn<int>(
      'cantidad_actual', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _costoUnitarioMeta =
      const VerificationMeta('costoUnitario');
  @override
  late final GeneratedColumn<double> costoUnitario = GeneratedColumn<double>(
      'costo_unitario', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productoId,
        numeroLote,
        fechaVencimiento,
        cantidadActual,
        costoUnitario
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lotes';
  @override
  VerificationContext validateIntegrity(Insertable<Lote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('producto_id')) {
      context.handle(
          _productoIdMeta,
          productoId.isAcceptableOrUnknown(
              data['producto_id']!, _productoIdMeta));
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('numero_lote')) {
      context.handle(
          _numeroLoteMeta,
          numeroLote.isAcceptableOrUnknown(
              data['numero_lote']!, _numeroLoteMeta));
    }
    if (data.containsKey('fecha_vencimiento')) {
      context.handle(
          _fechaVencimientoMeta,
          fechaVencimiento.isAcceptableOrUnknown(
              data['fecha_vencimiento']!, _fechaVencimientoMeta));
    }
    if (data.containsKey('cantidad_actual')) {
      context.handle(
          _cantidadActualMeta,
          cantidadActual.isAcceptableOrUnknown(
              data['cantidad_actual']!, _cantidadActualMeta));
    } else if (isInserting) {
      context.missing(_cantidadActualMeta);
    }
    if (data.containsKey('costo_unitario')) {
      context.handle(
          _costoUnitarioMeta,
          costoUnitario.isAcceptableOrUnknown(
              data['costo_unitario']!, _costoUnitarioMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      productoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}producto_id'])!,
      numeroLote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero_lote']),
      fechaVencimiento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_vencimiento']),
      cantidadActual: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad_actual'])!,
      costoUnitario: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}costo_unitario']),
    );
  }

  @override
  $LotesTable createAlias(String alias) {
    return $LotesTable(attachedDatabase, alias);
  }
}

class Lote extends DataClass implements Insertable<Lote> {
  final int id;
  final int productoId;
  final String? numeroLote;
  final DateTime? fechaVencimiento;
  final int cantidadActual;
  final double? costoUnitario;
  const Lote(
      {required this.id,
      required this.productoId,
      this.numeroLote,
      this.fechaVencimiento,
      required this.cantidadActual,
      this.costoUnitario});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['producto_id'] = Variable<int>(productoId);
    if (!nullToAbsent || numeroLote != null) {
      map['numero_lote'] = Variable<String>(numeroLote);
    }
    if (!nullToAbsent || fechaVencimiento != null) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento);
    }
    map['cantidad_actual'] = Variable<int>(cantidadActual);
    if (!nullToAbsent || costoUnitario != null) {
      map['costo_unitario'] = Variable<double>(costoUnitario);
    }
    return map;
  }

  LotesCompanion toCompanion(bool nullToAbsent) {
    return LotesCompanion(
      id: Value(id),
      productoId: Value(productoId),
      numeroLote: numeroLote == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroLote),
      fechaVencimiento: fechaVencimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaVencimiento),
      cantidadActual: Value(cantidadActual),
      costoUnitario: costoUnitario == null && nullToAbsent
          ? const Value.absent()
          : Value(costoUnitario),
    );
  }

  factory Lote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lote(
      id: serializer.fromJson<int>(json['id']),
      productoId: serializer.fromJson<int>(json['productoId']),
      numeroLote: serializer.fromJson<String?>(json['numeroLote']),
      fechaVencimiento:
          serializer.fromJson<DateTime?>(json['fechaVencimiento']),
      cantidadActual: serializer.fromJson<int>(json['cantidadActual']),
      costoUnitario: serializer.fromJson<double?>(json['costoUnitario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoId': serializer.toJson<int>(productoId),
      'numeroLote': serializer.toJson<String?>(numeroLote),
      'fechaVencimiento': serializer.toJson<DateTime?>(fechaVencimiento),
      'cantidadActual': serializer.toJson<int>(cantidadActual),
      'costoUnitario': serializer.toJson<double?>(costoUnitario),
    };
  }

  Lote copyWith(
          {int? id,
          int? productoId,
          Value<String?> numeroLote = const Value.absent(),
          Value<DateTime?> fechaVencimiento = const Value.absent(),
          int? cantidadActual,
          Value<double?> costoUnitario = const Value.absent()}) =>
      Lote(
        id: id ?? this.id,
        productoId: productoId ?? this.productoId,
        numeroLote: numeroLote.present ? numeroLote.value : this.numeroLote,
        fechaVencimiento: fechaVencimiento.present
            ? fechaVencimiento.value
            : this.fechaVencimiento,
        cantidadActual: cantidadActual ?? this.cantidadActual,
        costoUnitario:
            costoUnitario.present ? costoUnitario.value : this.costoUnitario,
      );
  Lote copyWithCompanion(LotesCompanion data) {
    return Lote(
      id: data.id.present ? data.id.value : this.id,
      productoId:
          data.productoId.present ? data.productoId.value : this.productoId,
      numeroLote:
          data.numeroLote.present ? data.numeroLote.value : this.numeroLote,
      fechaVencimiento: data.fechaVencimiento.present
          ? data.fechaVencimiento.value
          : this.fechaVencimiento,
      cantidadActual: data.cantidadActual.present
          ? data.cantidadActual.value
          : this.cantidadActual,
      costoUnitario: data.costoUnitario.present
          ? data.costoUnitario.value
          : this.costoUnitario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lote(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('numeroLote: $numeroLote, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('cantidadActual: $cantidadActual, ')
          ..write('costoUnitario: $costoUnitario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productoId, numeroLote, fechaVencimiento,
      cantidadActual, costoUnitario);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lote &&
          other.id == this.id &&
          other.productoId == this.productoId &&
          other.numeroLote == this.numeroLote &&
          other.fechaVencimiento == this.fechaVencimiento &&
          other.cantidadActual == this.cantidadActual &&
          other.costoUnitario == this.costoUnitario);
}

class LotesCompanion extends UpdateCompanion<Lote> {
  final Value<int> id;
  final Value<int> productoId;
  final Value<String?> numeroLote;
  final Value<DateTime?> fechaVencimiento;
  final Value<int> cantidadActual;
  final Value<double?> costoUnitario;
  const LotesCompanion({
    this.id = const Value.absent(),
    this.productoId = const Value.absent(),
    this.numeroLote = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.cantidadActual = const Value.absent(),
    this.costoUnitario = const Value.absent(),
  });
  LotesCompanion.insert({
    this.id = const Value.absent(),
    required int productoId,
    this.numeroLote = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    required int cantidadActual,
    this.costoUnitario = const Value.absent(),
  })  : productoId = Value(productoId),
        cantidadActual = Value(cantidadActual);
  static Insertable<Lote> custom({
    Expression<int>? id,
    Expression<int>? productoId,
    Expression<String>? numeroLote,
    Expression<DateTime>? fechaVencimiento,
    Expression<int>? cantidadActual,
    Expression<double>? costoUnitario,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productoId != null) 'producto_id': productoId,
      if (numeroLote != null) 'numero_lote': numeroLote,
      if (fechaVencimiento != null) 'fecha_vencimiento': fechaVencimiento,
      if (cantidadActual != null) 'cantidad_actual': cantidadActual,
      if (costoUnitario != null) 'costo_unitario': costoUnitario,
    });
  }

  LotesCompanion copyWith(
      {Value<int>? id,
      Value<int>? productoId,
      Value<String?>? numeroLote,
      Value<DateTime?>? fechaVencimiento,
      Value<int>? cantidadActual,
      Value<double?>? costoUnitario}) {
    return LotesCompanion(
      id: id ?? this.id,
      productoId: productoId ?? this.productoId,
      numeroLote: numeroLote ?? this.numeroLote,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      costoUnitario: costoUnitario ?? this.costoUnitario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (numeroLote.present) {
      map['numero_lote'] = Variable<String>(numeroLote.value);
    }
    if (fechaVencimiento.present) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento.value);
    }
    if (cantidadActual.present) {
      map['cantidad_actual'] = Variable<int>(cantidadActual.value);
    }
    if (costoUnitario.present) {
      map['costo_unitario'] = Variable<double>(costoUnitario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotesCompanion(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('numeroLote: $numeroLote, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('cantidadActual: $cantidadActual, ')
          ..write('costoUnitario: $costoUnitario')
          ..write(')'))
        .toString();
  }
}

class $SintomasTable extends Sintomas with TableInfo<$SintomasTable, Sintoma> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SintomasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sintomas';
  @override
  VerificationContext validateIntegrity(Insertable<Sintoma> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sintoma map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sintoma(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
    );
  }

  @override
  $SintomasTable createAlias(String alias) {
    return $SintomasTable(attachedDatabase, alias);
  }
}

class Sintoma extends DataClass implements Insertable<Sintoma> {
  final int id;
  final String nombre;
  const Sintoma({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  SintomasCompanion toCompanion(bool nullToAbsent) {
    return SintomasCompanion(
      id: Value(id),
      nombre: Value(nombre),
    );
  }

  factory Sintoma.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sintoma(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Sintoma copyWith({int? id, String? nombre}) => Sintoma(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
  Sintoma copyWithCompanion(SintomasCompanion data) {
    return Sintoma(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sintoma(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sintoma && other.id == this.id && other.nombre == this.nombre);
}

class SintomasCompanion extends UpdateCompanion<Sintoma> {
  final Value<int> id;
  final Value<String> nombre;
  const SintomasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  SintomasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Sintoma> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  SintomasCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return SintomasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SintomasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $ProductoSintomasTable extends ProductoSintomas
    with TableInfo<$ProductoSintomasTable, ProductoSintoma> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductoSintomasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productoIdMeta =
      const VerificationMeta('productoId');
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
      'producto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES productos (id)'));
  static const VerificationMeta _sintomaIdMeta =
      const VerificationMeta('sintomaId');
  @override
  late final GeneratedColumn<int> sintomaId = GeneratedColumn<int>(
      'sintoma_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sintomas (id)'));
  @override
  List<GeneratedColumn> get $columns => [productoId, sintomaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'producto_sintomas';
  @override
  VerificationContext validateIntegrity(Insertable<ProductoSintoma> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('producto_id')) {
      context.handle(
          _productoIdMeta,
          productoId.isAcceptableOrUnknown(
              data['producto_id']!, _productoIdMeta));
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('sintoma_id')) {
      context.handle(_sintomaIdMeta,
          sintomaId.isAcceptableOrUnknown(data['sintoma_id']!, _sintomaIdMeta));
    } else if (isInserting) {
      context.missing(_sintomaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productoId, sintomaId};
  @override
  ProductoSintoma map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductoSintoma(
      productoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}producto_id'])!,
      sintomaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sintoma_id'])!,
    );
  }

  @override
  $ProductoSintomasTable createAlias(String alias) {
    return $ProductoSintomasTable(attachedDatabase, alias);
  }
}

class ProductoSintoma extends DataClass implements Insertable<ProductoSintoma> {
  final int productoId;
  final int sintomaId;
  const ProductoSintoma({required this.productoId, required this.sintomaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['producto_id'] = Variable<int>(productoId);
    map['sintoma_id'] = Variable<int>(sintomaId);
    return map;
  }

  ProductoSintomasCompanion toCompanion(bool nullToAbsent) {
    return ProductoSintomasCompanion(
      productoId: Value(productoId),
      sintomaId: Value(sintomaId),
    );
  }

  factory ProductoSintoma.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductoSintoma(
      productoId: serializer.fromJson<int>(json['productoId']),
      sintomaId: serializer.fromJson<int>(json['sintomaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productoId': serializer.toJson<int>(productoId),
      'sintomaId': serializer.toJson<int>(sintomaId),
    };
  }

  ProductoSintoma copyWith({int? productoId, int? sintomaId}) =>
      ProductoSintoma(
        productoId: productoId ?? this.productoId,
        sintomaId: sintomaId ?? this.sintomaId,
      );
  ProductoSintoma copyWithCompanion(ProductoSintomasCompanion data) {
    return ProductoSintoma(
      productoId:
          data.productoId.present ? data.productoId.value : this.productoId,
      sintomaId: data.sintomaId.present ? data.sintomaId.value : this.sintomaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductoSintoma(')
          ..write('productoId: $productoId, ')
          ..write('sintomaId: $sintomaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productoId, sintomaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductoSintoma &&
          other.productoId == this.productoId &&
          other.sintomaId == this.sintomaId);
}

class ProductoSintomasCompanion extends UpdateCompanion<ProductoSintoma> {
  final Value<int> productoId;
  final Value<int> sintomaId;
  final Value<int> rowid;
  const ProductoSintomasCompanion({
    this.productoId = const Value.absent(),
    this.sintomaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductoSintomasCompanion.insert({
    required int productoId,
    required int sintomaId,
    this.rowid = const Value.absent(),
  })  : productoId = Value(productoId),
        sintomaId = Value(sintomaId);
  static Insertable<ProductoSintoma> custom({
    Expression<int>? productoId,
    Expression<int>? sintomaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productoId != null) 'producto_id': productoId,
      if (sintomaId != null) 'sintoma_id': sintomaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductoSintomasCompanion copyWith(
      {Value<int>? productoId, Value<int>? sintomaId, Value<int>? rowid}) {
    return ProductoSintomasCompanion(
      productoId: productoId ?? this.productoId,
      sintomaId: sintomaId ?? this.sintomaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (sintomaId.present) {
      map['sintoma_id'] = Variable<int>(sintomaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductoSintomasCompanion(')
          ..write('productoId: $productoId, ')
          ..write('sintomaId: $sintomaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nitMeta = const VerificationMeta('nit');
  @override
  late final GeneratedColumn<String> nit = GeneratedColumn<String>(
      'nit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, nombre, telefono, nit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(Insertable<Cliente> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    }
    if (data.containsKey('nit')) {
      context.handle(
          _nitMeta, nit.isAcceptableOrUnknown(data['nit']!, _nitMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono']),
      nit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nit']),
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final int id;
  final String nombre;
  final String? telefono;
  final String? nit;
  const Cliente(
      {required this.id, required this.nombre, this.telefono, this.nit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || nit != null) {
      map['nit'] = Variable<String>(nit);
    }
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      nit: nit == null && nullToAbsent ? const Value.absent() : Value(nit),
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      nit: serializer.fromJson<String?>(json['nit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String?>(telefono),
      'nit': serializer.toJson<String?>(nit),
    };
  }

  Cliente copyWith(
          {int? id,
          String? nombre,
          Value<String?> telefono = const Value.absent(),
          Value<String?> nit = const Value.absent()}) =>
      Cliente(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        telefono: telefono.present ? telefono.value : this.telefono,
        nit: nit.present ? nit.value : this.nit,
      );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      nit: data.nit.present ? data.nit.value : this.nit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('nit: $nit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, telefono, nit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.telefono == this.telefono &&
          other.nit == this.nit);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> telefono;
  final Value<String?> nit;
  const ClientesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
    this.nit = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.telefono = const Value.absent(),
    this.nit = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Cliente> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? telefono,
    Expression<String>? nit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (telefono != null) 'telefono': telefono,
      if (nit != null) 'nit': nit,
    });
  }

  ClientesCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String?>? telefono,
      Value<String?>? nit}) {
    return ClientesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      nit: nit ?? this.nit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (nit.present) {
      map['nit'] = Variable<String>(nit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('nit: $nit')
          ..write(')'))
        .toString();
  }
}

class $RecetasTable extends Recetas with TableInfo<$RecetasTable, Receta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecetasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _pacienteMeta =
      const VerificationMeta('paciente');
  @override
  late final GeneratedColumn<String> paciente = GeneratedColumn<String>(
      'paciente', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _medicoMeta = const VerificationMeta('medico');
  @override
  late final GeneratedColumn<String> medico = GeneratedColumn<String>(
      'medico', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaEmisionMeta =
      const VerificationMeta('fechaEmision');
  @override
  late final GeneratedColumn<DateTime> fechaEmision = GeneratedColumn<DateTime>(
      'fecha_emision', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fechaVencimientoMeta =
      const VerificationMeta('fechaVencimiento');
  @override
  late final GeneratedColumn<DateTime> fechaVencimiento =
      GeneratedColumn<DateTime>('fecha_vencimiento', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendiente'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, numero, paciente, medico, fechaEmision, fechaVencimiento, estado];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recetas';
  @override
  VerificationContext validateIntegrity(Insertable<Receta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('paciente')) {
      context.handle(_pacienteMeta,
          paciente.isAcceptableOrUnknown(data['paciente']!, _pacienteMeta));
    } else if (isInserting) {
      context.missing(_pacienteMeta);
    }
    if (data.containsKey('medico')) {
      context.handle(_medicoMeta,
          medico.isAcceptableOrUnknown(data['medico']!, _medicoMeta));
    }
    if (data.containsKey('fecha_emision')) {
      context.handle(
          _fechaEmisionMeta,
          fechaEmision.isAcceptableOrUnknown(
              data['fecha_emision']!, _fechaEmisionMeta));
    } else if (isInserting) {
      context.missing(_fechaEmisionMeta);
    }
    if (data.containsKey('fecha_vencimiento')) {
      context.handle(
          _fechaVencimientoMeta,
          fechaVencimiento.isAcceptableOrUnknown(
              data['fecha_vencimiento']!, _fechaVencimientoMeta));
    } else if (isInserting) {
      context.missing(_fechaVencimientoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      numero: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
      paciente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}paciente'])!,
      medico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medico']),
      fechaEmision: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_emision'])!,
      fechaVencimiento: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_vencimiento'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
    );
  }

  @override
  $RecetasTable createAlias(String alias) {
    return $RecetasTable(attachedDatabase, alias);
  }
}

class Receta extends DataClass implements Insertable<Receta> {
  final int id;
  final String numero;
  final String paciente;
  final String? medico;
  final DateTime fechaEmision;
  final DateTime fechaVencimiento;
  final String estado;
  const Receta(
      {required this.id,
      required this.numero,
      required this.paciente,
      this.medico,
      required this.fechaEmision,
      required this.fechaVencimiento,
      required this.estado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['numero'] = Variable<String>(numero);
    map['paciente'] = Variable<String>(paciente);
    if (!nullToAbsent || medico != null) {
      map['medico'] = Variable<String>(medico);
    }
    map['fecha_emision'] = Variable<DateTime>(fechaEmision);
    map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento);
    map['estado'] = Variable<String>(estado);
    return map;
  }

  RecetasCompanion toCompanion(bool nullToAbsent) {
    return RecetasCompanion(
      id: Value(id),
      numero: Value(numero),
      paciente: Value(paciente),
      medico:
          medico == null && nullToAbsent ? const Value.absent() : Value(medico),
      fechaEmision: Value(fechaEmision),
      fechaVencimiento: Value(fechaVencimiento),
      estado: Value(estado),
    );
  }

  factory Receta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receta(
      id: serializer.fromJson<int>(json['id']),
      numero: serializer.fromJson<String>(json['numero']),
      paciente: serializer.fromJson<String>(json['paciente']),
      medico: serializer.fromJson<String?>(json['medico']),
      fechaEmision: serializer.fromJson<DateTime>(json['fechaEmision']),
      fechaVencimiento: serializer.fromJson<DateTime>(json['fechaVencimiento']),
      estado: serializer.fromJson<String>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'numero': serializer.toJson<String>(numero),
      'paciente': serializer.toJson<String>(paciente),
      'medico': serializer.toJson<String?>(medico),
      'fechaEmision': serializer.toJson<DateTime>(fechaEmision),
      'fechaVencimiento': serializer.toJson<DateTime>(fechaVencimiento),
      'estado': serializer.toJson<String>(estado),
    };
  }

  Receta copyWith(
          {int? id,
          String? numero,
          String? paciente,
          Value<String?> medico = const Value.absent(),
          DateTime? fechaEmision,
          DateTime? fechaVencimiento,
          String? estado}) =>
      Receta(
        id: id ?? this.id,
        numero: numero ?? this.numero,
        paciente: paciente ?? this.paciente,
        medico: medico.present ? medico.value : this.medico,
        fechaEmision: fechaEmision ?? this.fechaEmision,
        fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
        estado: estado ?? this.estado,
      );
  Receta copyWithCompanion(RecetasCompanion data) {
    return Receta(
      id: data.id.present ? data.id.value : this.id,
      numero: data.numero.present ? data.numero.value : this.numero,
      paciente: data.paciente.present ? data.paciente.value : this.paciente,
      medico: data.medico.present ? data.medico.value : this.medico,
      fechaEmision: data.fechaEmision.present
          ? data.fechaEmision.value
          : this.fechaEmision,
      fechaVencimiento: data.fechaVencimiento.present
          ? data.fechaVencimiento.value
          : this.fechaVencimiento,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receta(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('paciente: $paciente, ')
          ..write('medico: $medico, ')
          ..write('fechaEmision: $fechaEmision, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, numero, paciente, medico, fechaEmision, fechaVencimiento, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receta &&
          other.id == this.id &&
          other.numero == this.numero &&
          other.paciente == this.paciente &&
          other.medico == this.medico &&
          other.fechaEmision == this.fechaEmision &&
          other.fechaVencimiento == this.fechaVencimiento &&
          other.estado == this.estado);
}

class RecetasCompanion extends UpdateCompanion<Receta> {
  final Value<int> id;
  final Value<String> numero;
  final Value<String> paciente;
  final Value<String?> medico;
  final Value<DateTime> fechaEmision;
  final Value<DateTime> fechaVencimiento;
  final Value<String> estado;
  const RecetasCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.paciente = const Value.absent(),
    this.medico = const Value.absent(),
    this.fechaEmision = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.estado = const Value.absent(),
  });
  RecetasCompanion.insert({
    this.id = const Value.absent(),
    required String numero,
    required String paciente,
    this.medico = const Value.absent(),
    required DateTime fechaEmision,
    required DateTime fechaVencimiento,
    this.estado = const Value.absent(),
  })  : numero = Value(numero),
        paciente = Value(paciente),
        fechaEmision = Value(fechaEmision),
        fechaVencimiento = Value(fechaVencimiento);
  static Insertable<Receta> custom({
    Expression<int>? id,
    Expression<String>? numero,
    Expression<String>? paciente,
    Expression<String>? medico,
    Expression<DateTime>? fechaEmision,
    Expression<DateTime>? fechaVencimiento,
    Expression<String>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numero != null) 'numero': numero,
      if (paciente != null) 'paciente': paciente,
      if (medico != null) 'medico': medico,
      if (fechaEmision != null) 'fecha_emision': fechaEmision,
      if (fechaVencimiento != null) 'fecha_vencimiento': fechaVencimiento,
      if (estado != null) 'estado': estado,
    });
  }

  RecetasCompanion copyWith(
      {Value<int>? id,
      Value<String>? numero,
      Value<String>? paciente,
      Value<String?>? medico,
      Value<DateTime>? fechaEmision,
      Value<DateTime>? fechaVencimiento,
      Value<String>? estado}) {
    return RecetasCompanion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      paciente: paciente ?? this.paciente,
      medico: medico ?? this.medico,
      fechaEmision: fechaEmision ?? this.fechaEmision,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (paciente.present) {
      map['paciente'] = Variable<String>(paciente.value);
    }
    if (medico.present) {
      map['medico'] = Variable<String>(medico.value);
    }
    if (fechaEmision.present) {
      map['fecha_emision'] = Variable<DateTime>(fechaEmision.value);
    }
    if (fechaVencimiento.present) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecetasCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('paciente: $paciente, ')
          ..write('medico: $medico, ')
          ..write('fechaEmision: $fechaEmision, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $DetalleRecetasTable extends DetalleRecetas
    with TableInfo<$DetalleRecetasTable, DetalleReceta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetalleRecetasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _recetaIdMeta =
      const VerificationMeta('recetaId');
  @override
  late final GeneratedColumn<int> recetaId = GeneratedColumn<int>(
      'receta_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES recetas (id)'));
  static const VerificationMeta _productoIdMeta =
      const VerificationMeta('productoId');
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
      'producto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES productos (id)'));
  static const VerificationMeta _cantidadAutorizadaMeta =
      const VerificationMeta('cantidadAutorizada');
  @override
  late final GeneratedColumn<int> cantidadAutorizada = GeneratedColumn<int>(
      'cantidad_autorizada', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cantidadDispensadaMeta =
      const VerificationMeta('cantidadDispensada');
  @override
  late final GeneratedColumn<int> cantidadDispensada = GeneratedColumn<int>(
      'cantidad_dispensada', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, recetaId, productoId, cantidadAutorizada, cantidadDispensada];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detalle_recetas';
  @override
  VerificationContext validateIntegrity(Insertable<DetalleReceta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receta_id')) {
      context.handle(_recetaIdMeta,
          recetaId.isAcceptableOrUnknown(data['receta_id']!, _recetaIdMeta));
    } else if (isInserting) {
      context.missing(_recetaIdMeta);
    }
    if (data.containsKey('producto_id')) {
      context.handle(
          _productoIdMeta,
          productoId.isAcceptableOrUnknown(
              data['producto_id']!, _productoIdMeta));
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('cantidad_autorizada')) {
      context.handle(
          _cantidadAutorizadaMeta,
          cantidadAutorizada.isAcceptableOrUnknown(
              data['cantidad_autorizada']!, _cantidadAutorizadaMeta));
    } else if (isInserting) {
      context.missing(_cantidadAutorizadaMeta);
    }
    if (data.containsKey('cantidad_dispensada')) {
      context.handle(
          _cantidadDispensadaMeta,
          cantidadDispensada.isAcceptableOrUnknown(
              data['cantidad_dispensada']!, _cantidadDispensadaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetalleReceta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetalleReceta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      recetaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}receta_id'])!,
      productoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}producto_id'])!,
      cantidadAutorizada: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}cantidad_autorizada'])!,
      cantidadDispensada: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}cantidad_dispensada'])!,
    );
  }

  @override
  $DetalleRecetasTable createAlias(String alias) {
    return $DetalleRecetasTable(attachedDatabase, alias);
  }
}

class DetalleReceta extends DataClass implements Insertable<DetalleReceta> {
  final int id;
  final int recetaId;
  final int productoId;
  final int cantidadAutorizada;
  final int cantidadDispensada;
  const DetalleReceta(
      {required this.id,
      required this.recetaId,
      required this.productoId,
      required this.cantidadAutorizada,
      required this.cantidadDispensada});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['receta_id'] = Variable<int>(recetaId);
    map['producto_id'] = Variable<int>(productoId);
    map['cantidad_autorizada'] = Variable<int>(cantidadAutorizada);
    map['cantidad_dispensada'] = Variable<int>(cantidadDispensada);
    return map;
  }

  DetalleRecetasCompanion toCompanion(bool nullToAbsent) {
    return DetalleRecetasCompanion(
      id: Value(id),
      recetaId: Value(recetaId),
      productoId: Value(productoId),
      cantidadAutorizada: Value(cantidadAutorizada),
      cantidadDispensada: Value(cantidadDispensada),
    );
  }

  factory DetalleReceta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetalleReceta(
      id: serializer.fromJson<int>(json['id']),
      recetaId: serializer.fromJson<int>(json['recetaId']),
      productoId: serializer.fromJson<int>(json['productoId']),
      cantidadAutorizada: serializer.fromJson<int>(json['cantidadAutorizada']),
      cantidadDispensada: serializer.fromJson<int>(json['cantidadDispensada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recetaId': serializer.toJson<int>(recetaId),
      'productoId': serializer.toJson<int>(productoId),
      'cantidadAutorizada': serializer.toJson<int>(cantidadAutorizada),
      'cantidadDispensada': serializer.toJson<int>(cantidadDispensada),
    };
  }

  DetalleReceta copyWith(
          {int? id,
          int? recetaId,
          int? productoId,
          int? cantidadAutorizada,
          int? cantidadDispensada}) =>
      DetalleReceta(
        id: id ?? this.id,
        recetaId: recetaId ?? this.recetaId,
        productoId: productoId ?? this.productoId,
        cantidadAutorizada: cantidadAutorizada ?? this.cantidadAutorizada,
        cantidadDispensada: cantidadDispensada ?? this.cantidadDispensada,
      );
  DetalleReceta copyWithCompanion(DetalleRecetasCompanion data) {
    return DetalleReceta(
      id: data.id.present ? data.id.value : this.id,
      recetaId: data.recetaId.present ? data.recetaId.value : this.recetaId,
      productoId:
          data.productoId.present ? data.productoId.value : this.productoId,
      cantidadAutorizada: data.cantidadAutorizada.present
          ? data.cantidadAutorizada.value
          : this.cantidadAutorizada,
      cantidadDispensada: data.cantidadDispensada.present
          ? data.cantidadDispensada.value
          : this.cantidadDispensada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetalleReceta(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('productoId: $productoId, ')
          ..write('cantidadAutorizada: $cantidadAutorizada, ')
          ..write('cantidadDispensada: $cantidadDispensada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, recetaId, productoId, cantidadAutorizada, cantidadDispensada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetalleReceta &&
          other.id == this.id &&
          other.recetaId == this.recetaId &&
          other.productoId == this.productoId &&
          other.cantidadAutorizada == this.cantidadAutorizada &&
          other.cantidadDispensada == this.cantidadDispensada);
}

class DetalleRecetasCompanion extends UpdateCompanion<DetalleReceta> {
  final Value<int> id;
  final Value<int> recetaId;
  final Value<int> productoId;
  final Value<int> cantidadAutorizada;
  final Value<int> cantidadDispensada;
  const DetalleRecetasCompanion({
    this.id = const Value.absent(),
    this.recetaId = const Value.absent(),
    this.productoId = const Value.absent(),
    this.cantidadAutorizada = const Value.absent(),
    this.cantidadDispensada = const Value.absent(),
  });
  DetalleRecetasCompanion.insert({
    this.id = const Value.absent(),
    required int recetaId,
    required int productoId,
    required int cantidadAutorizada,
    this.cantidadDispensada = const Value.absent(),
  })  : recetaId = Value(recetaId),
        productoId = Value(productoId),
        cantidadAutorizada = Value(cantidadAutorizada);
  static Insertable<DetalleReceta> custom({
    Expression<int>? id,
    Expression<int>? recetaId,
    Expression<int>? productoId,
    Expression<int>? cantidadAutorizada,
    Expression<int>? cantidadDispensada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recetaId != null) 'receta_id': recetaId,
      if (productoId != null) 'producto_id': productoId,
      if (cantidadAutorizada != null) 'cantidad_autorizada': cantidadAutorizada,
      if (cantidadDispensada != null) 'cantidad_dispensada': cantidadDispensada,
    });
  }

  DetalleRecetasCompanion copyWith(
      {Value<int>? id,
      Value<int>? recetaId,
      Value<int>? productoId,
      Value<int>? cantidadAutorizada,
      Value<int>? cantidadDispensada}) {
    return DetalleRecetasCompanion(
      id: id ?? this.id,
      recetaId: recetaId ?? this.recetaId,
      productoId: productoId ?? this.productoId,
      cantidadAutorizada: cantidadAutorizada ?? this.cantidadAutorizada,
      cantidadDispensada: cantidadDispensada ?? this.cantidadDispensada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recetaId.present) {
      map['receta_id'] = Variable<int>(recetaId.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (cantidadAutorizada.present) {
      map['cantidad_autorizada'] = Variable<int>(cantidadAutorizada.value);
    }
    if (cantidadDispensada.present) {
      map['cantidad_dispensada'] = Variable<int>(cantidadDispensada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetalleRecetasCompanion(')
          ..write('id: $id, ')
          ..write('recetaId: $recetaId, ')
          ..write('productoId: $productoId, ')
          ..write('cantidadAutorizada: $cantidadAutorizada, ')
          ..write('cantidadDispensada: $cantidadDispensada')
          ..write(')'))
        .toString();
  }
}

class $VentasTable extends Ventas with TableInfo<$VentasTable, Venta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usuarioIdMeta =
      const VerificationMeta('usuarioId');
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
      'usuario_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES usuarios (id)'));
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
      'cliente_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clientes (id)'));
  static const VerificationMeta _fechaHoraMeta =
      const VerificationMeta('fechaHora');
  @override
  late final GeneratedColumn<DateTime> fechaHora = GeneratedColumn<DateTime>(
      'fecha_hora', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _igvMeta = const VerificationMeta('igv');
  @override
  late final GeneratedColumn<double> igv = GeneratedColumn<double>(
      'igv', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _metodoPagoMeta =
      const VerificationMeta('metodoPago');
  @override
  late final GeneratedColumn<String> metodoPago = GeneratedColumn<String>(
      'metodo_pago', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('completada'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        usuarioId,
        clienteId,
        fechaHora,
        subtotal,
        igv,
        total,
        metodoPago,
        estado
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ventas';
  @override
  VerificationContext validateIntegrity(Insertable<Venta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(_usuarioIdMeta,
          usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta));
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    }
    if (data.containsKey('fecha_hora')) {
      context.handle(_fechaHoraMeta,
          fechaHora.isAcceptableOrUnknown(data['fecha_hora']!, _fechaHoraMeta));
    } else if (isInserting) {
      context.missing(_fechaHoraMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('igv')) {
      context.handle(
          _igvMeta, igv.isAcceptableOrUnknown(data['igv']!, _igvMeta));
    } else if (isInserting) {
      context.missing(_igvMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('metodo_pago')) {
      context.handle(
          _metodoPagoMeta,
          metodoPago.isAcceptableOrUnknown(
              data['metodo_pago']!, _metodoPagoMeta));
    } else if (isInserting) {
      context.missing(_metodoPagoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Venta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Venta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      usuarioId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usuario_id'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_id']),
      fechaHora: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_hora'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      igv: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}igv'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      metodoPago: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metodo_pago'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
    );
  }

  @override
  $VentasTable createAlias(String alias) {
    return $VentasTable(attachedDatabase, alias);
  }
}

class Venta extends DataClass implements Insertable<Venta> {
  final int id;
  final int usuarioId;
  final int? clienteId;
  final DateTime fechaHora;
  final double subtotal;
  final double igv;
  final double total;
  final String metodoPago;
  final String estado;
  const Venta(
      {required this.id,
      required this.usuarioId,
      this.clienteId,
      required this.fechaHora,
      required this.subtotal,
      required this.igv,
      required this.total,
      required this.metodoPago,
      required this.estado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    if (!nullToAbsent || clienteId != null) {
      map['cliente_id'] = Variable<int>(clienteId);
    }
    map['fecha_hora'] = Variable<DateTime>(fechaHora);
    map['subtotal'] = Variable<double>(subtotal);
    map['igv'] = Variable<double>(igv);
    map['total'] = Variable<double>(total);
    map['metodo_pago'] = Variable<String>(metodoPago);
    map['estado'] = Variable<String>(estado);
    return map;
  }

  VentasCompanion toCompanion(bool nullToAbsent) {
    return VentasCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      clienteId: clienteId == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteId),
      fechaHora: Value(fechaHora),
      subtotal: Value(subtotal),
      igv: Value(igv),
      total: Value(total),
      metodoPago: Value(metodoPago),
      estado: Value(estado),
    );
  }

  factory Venta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venta(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      clienteId: serializer.fromJson<int?>(json['clienteId']),
      fechaHora: serializer.fromJson<DateTime>(json['fechaHora']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      igv: serializer.fromJson<double>(json['igv']),
      total: serializer.fromJson<double>(json['total']),
      metodoPago: serializer.fromJson<String>(json['metodoPago']),
      estado: serializer.fromJson<String>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'clienteId': serializer.toJson<int?>(clienteId),
      'fechaHora': serializer.toJson<DateTime>(fechaHora),
      'subtotal': serializer.toJson<double>(subtotal),
      'igv': serializer.toJson<double>(igv),
      'total': serializer.toJson<double>(total),
      'metodoPago': serializer.toJson<String>(metodoPago),
      'estado': serializer.toJson<String>(estado),
    };
  }

  Venta copyWith(
          {int? id,
          int? usuarioId,
          Value<int?> clienteId = const Value.absent(),
          DateTime? fechaHora,
          double? subtotal,
          double? igv,
          double? total,
          String? metodoPago,
          String? estado}) =>
      Venta(
        id: id ?? this.id,
        usuarioId: usuarioId ?? this.usuarioId,
        clienteId: clienteId.present ? clienteId.value : this.clienteId,
        fechaHora: fechaHora ?? this.fechaHora,
        subtotal: subtotal ?? this.subtotal,
        igv: igv ?? this.igv,
        total: total ?? this.total,
        metodoPago: metodoPago ?? this.metodoPago,
        estado: estado ?? this.estado,
      );
  Venta copyWithCompanion(VentasCompanion data) {
    return Venta(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      fechaHora: data.fechaHora.present ? data.fechaHora.value : this.fechaHora,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      igv: data.igv.present ? data.igv.value : this.igv,
      total: data.total.present ? data.total.value : this.total,
      metodoPago:
          data.metodoPago.present ? data.metodoPago.value : this.metodoPago,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Venta(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('clienteId: $clienteId, ')
          ..write('fechaHora: $fechaHora, ')
          ..write('subtotal: $subtotal, ')
          ..write('igv: $igv, ')
          ..write('total: $total, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, usuarioId, clienteId, fechaHora, subtotal,
      igv, total, metodoPago, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venta &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.clienteId == this.clienteId &&
          other.fechaHora == this.fechaHora &&
          other.subtotal == this.subtotal &&
          other.igv == this.igv &&
          other.total == this.total &&
          other.metodoPago == this.metodoPago &&
          other.estado == this.estado);
}

class VentasCompanion extends UpdateCompanion<Venta> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<int?> clienteId;
  final Value<DateTime> fechaHora;
  final Value<double> subtotal;
  final Value<double> igv;
  final Value<double> total;
  final Value<String> metodoPago;
  final Value<String> estado;
  const VentasCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.fechaHora = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.igv = const Value.absent(),
    this.total = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.estado = const Value.absent(),
  });
  VentasCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    this.clienteId = const Value.absent(),
    required DateTime fechaHora,
    required double subtotal,
    required double igv,
    required double total,
    required String metodoPago,
    this.estado = const Value.absent(),
  })  : usuarioId = Value(usuarioId),
        fechaHora = Value(fechaHora),
        subtotal = Value(subtotal),
        igv = Value(igv),
        total = Value(total),
        metodoPago = Value(metodoPago);
  static Insertable<Venta> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<int>? clienteId,
    Expression<DateTime>? fechaHora,
    Expression<double>? subtotal,
    Expression<double>? igv,
    Expression<double>? total,
    Expression<String>? metodoPago,
    Expression<String>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (clienteId != null) 'cliente_id': clienteId,
      if (fechaHora != null) 'fecha_hora': fechaHora,
      if (subtotal != null) 'subtotal': subtotal,
      if (igv != null) 'igv': igv,
      if (total != null) 'total': total,
      if (metodoPago != null) 'metodo_pago': metodoPago,
      if (estado != null) 'estado': estado,
    });
  }

  VentasCompanion copyWith(
      {Value<int>? id,
      Value<int>? usuarioId,
      Value<int?>? clienteId,
      Value<DateTime>? fechaHora,
      Value<double>? subtotal,
      Value<double>? igv,
      Value<double>? total,
      Value<String>? metodoPago,
      Value<String>? estado}) {
    return VentasCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      clienteId: clienteId ?? this.clienteId,
      fechaHora: fechaHora ?? this.fechaHora,
      subtotal: subtotal ?? this.subtotal,
      igv: igv ?? this.igv,
      total: total ?? this.total,
      metodoPago: metodoPago ?? this.metodoPago,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (fechaHora.present) {
      map['fecha_hora'] = Variable<DateTime>(fechaHora.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (igv.present) {
      map['igv'] = Variable<double>(igv.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (metodoPago.present) {
      map['metodo_pago'] = Variable<String>(metodoPago.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentasCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('clienteId: $clienteId, ')
          ..write('fechaHora: $fechaHora, ')
          ..write('subtotal: $subtotal, ')
          ..write('igv: $igv, ')
          ..write('total: $total, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $DetalleVentasTable extends DetalleVentas
    with TableInfo<$DetalleVentasTable, DetalleVenta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetalleVentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ventaIdMeta =
      const VerificationMeta('ventaId');
  @override
  late final GeneratedColumn<int> ventaId = GeneratedColumn<int>(
      'venta_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ventas (id)'));
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<int> loteId = GeneratedColumn<int>(
      'lote_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lotes (id)'));
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precioUnitarioMeta =
      const VerificationMeta('precioUnitario');
  @override
  late final GeneratedColumn<double> precioUnitario = GeneratedColumn<double>(
      'precio_unitario', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ventaId, loteId, cantidad, precioUnitario];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detalle_ventas';
  @override
  VerificationContext validateIntegrity(Insertable<DetalleVenta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('venta_id')) {
      context.handle(_ventaIdMeta,
          ventaId.isAcceptableOrUnknown(data['venta_id']!, _ventaIdMeta));
    } else if (isInserting) {
      context.missing(_ventaIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    } else if (isInserting) {
      context.missing(_loteIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
          _precioUnitarioMeta,
          precioUnitario.isAcceptableOrUnknown(
              data['precio_unitario']!, _precioUnitarioMeta));
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetalleVenta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetalleVenta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ventaId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}venta_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lote_id'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      precioUnitario: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}precio_unitario'])!,
    );
  }

  @override
  $DetalleVentasTable createAlias(String alias) {
    return $DetalleVentasTable(attachedDatabase, alias);
  }
}

class DetalleVenta extends DataClass implements Insertable<DetalleVenta> {
  final int id;
  final int ventaId;
  final int loteId;
  final int cantidad;
  final double precioUnitario;
  const DetalleVenta(
      {required this.id,
      required this.ventaId,
      required this.loteId,
      required this.cantidad,
      required this.precioUnitario});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['venta_id'] = Variable<int>(ventaId);
    map['lote_id'] = Variable<int>(loteId);
    map['cantidad'] = Variable<int>(cantidad);
    map['precio_unitario'] = Variable<double>(precioUnitario);
    return map;
  }

  DetalleVentasCompanion toCompanion(bool nullToAbsent) {
    return DetalleVentasCompanion(
      id: Value(id),
      ventaId: Value(ventaId),
      loteId: Value(loteId),
      cantidad: Value(cantidad),
      precioUnitario: Value(precioUnitario),
    );
  }

  factory DetalleVenta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetalleVenta(
      id: serializer.fromJson<int>(json['id']),
      ventaId: serializer.fromJson<int>(json['ventaId']),
      loteId: serializer.fromJson<int>(json['loteId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      precioUnitario: serializer.fromJson<double>(json['precioUnitario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ventaId': serializer.toJson<int>(ventaId),
      'loteId': serializer.toJson<int>(loteId),
      'cantidad': serializer.toJson<int>(cantidad),
      'precioUnitario': serializer.toJson<double>(precioUnitario),
    };
  }

  DetalleVenta copyWith(
          {int? id,
          int? ventaId,
          int? loteId,
          int? cantidad,
          double? precioUnitario}) =>
      DetalleVenta(
        id: id ?? this.id,
        ventaId: ventaId ?? this.ventaId,
        loteId: loteId ?? this.loteId,
        cantidad: cantidad ?? this.cantidad,
        precioUnitario: precioUnitario ?? this.precioUnitario,
      );
  DetalleVenta copyWithCompanion(DetalleVentasCompanion data) {
    return DetalleVenta(
      id: data.id.present ? data.id.value : this.id,
      ventaId: data.ventaId.present ? data.ventaId.value : this.ventaId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetalleVenta(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('loteId: $loteId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ventaId, loteId, cantidad, precioUnitario);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetalleVenta &&
          other.id == this.id &&
          other.ventaId == this.ventaId &&
          other.loteId == this.loteId &&
          other.cantidad == this.cantidad &&
          other.precioUnitario == this.precioUnitario);
}

class DetalleVentasCompanion extends UpdateCompanion<DetalleVenta> {
  final Value<int> id;
  final Value<int> ventaId;
  final Value<int> loteId;
  final Value<int> cantidad;
  final Value<double> precioUnitario;
  const DetalleVentasCompanion({
    this.id = const Value.absent(),
    this.ventaId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
  });
  DetalleVentasCompanion.insert({
    this.id = const Value.absent(),
    required int ventaId,
    required int loteId,
    required int cantidad,
    required double precioUnitario,
  })  : ventaId = Value(ventaId),
        loteId = Value(loteId),
        cantidad = Value(cantidad),
        precioUnitario = Value(precioUnitario);
  static Insertable<DetalleVenta> custom({
    Expression<int>? id,
    Expression<int>? ventaId,
    Expression<int>? loteId,
    Expression<int>? cantidad,
    Expression<double>? precioUnitario,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ventaId != null) 'venta_id': ventaId,
      if (loteId != null) 'lote_id': loteId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
    });
  }

  DetalleVentasCompanion copyWith(
      {Value<int>? id,
      Value<int>? ventaId,
      Value<int>? loteId,
      Value<int>? cantidad,
      Value<double>? precioUnitario}) {
    return DetalleVentasCompanion(
      id: id ?? this.id,
      ventaId: ventaId ?? this.ventaId,
      loteId: loteId ?? this.loteId,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ventaId.present) {
      map['venta_id'] = Variable<int>(ventaId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<int>(loteId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<double>(precioUnitario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetalleVentasCompanion(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('loteId: $loteId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }
}

class $AlertasTable extends Alertas with TableInfo<$AlertasTable, Alerta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlertasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productoIdMeta =
      const VerificationMeta('productoId');
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
      'producto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES productos (id)'));
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<int> loteId = GeneratedColumn<int>(
      'lote_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES lotes (id)'));
  static const VerificationMeta _fechaCreacionMeta =
      const VerificationMeta('fechaCreacion');
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>('fecha_creacion', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendiente'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, tipo, productoId, loteId, fechaCreacion, estado];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alertas';
  @override
  VerificationContext validateIntegrity(Insertable<Alerta> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('producto_id')) {
      context.handle(
          _productoIdMeta,
          productoId.isAcceptableOrUnknown(
              data['producto_id']!, _productoIdMeta));
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(_loteIdMeta,
          loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta));
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
          _fechaCreacionMeta,
          fechaCreacion.isAcceptableOrUnknown(
              data['fecha_creacion']!, _fechaCreacionMeta));
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alerta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alerta(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      productoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}producto_id'])!,
      loteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lote_id']),
      fechaCreacion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_creacion'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
    );
  }

  @override
  $AlertasTable createAlias(String alias) {
    return $AlertasTable(attachedDatabase, alias);
  }
}

class Alerta extends DataClass implements Insertable<Alerta> {
  final int id;
  final String tipo;
  final int productoId;
  final int? loteId;
  final DateTime fechaCreacion;
  final String estado;
  const Alerta(
      {required this.id,
      required this.tipo,
      required this.productoId,
      this.loteId,
      required this.fechaCreacion,
      required this.estado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    map['producto_id'] = Variable<int>(productoId);
    if (!nullToAbsent || loteId != null) {
      map['lote_id'] = Variable<int>(loteId);
    }
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    map['estado'] = Variable<String>(estado);
    return map;
  }

  AlertasCompanion toCompanion(bool nullToAbsent) {
    return AlertasCompanion(
      id: Value(id),
      tipo: Value(tipo),
      productoId: Value(productoId),
      loteId:
          loteId == null && nullToAbsent ? const Value.absent() : Value(loteId),
      fechaCreacion: Value(fechaCreacion),
      estado: Value(estado),
    );
  }

  factory Alerta.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alerta(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      productoId: serializer.fromJson<int>(json['productoId']),
      loteId: serializer.fromJson<int?>(json['loteId']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
      estado: serializer.fromJson<String>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'productoId': serializer.toJson<int>(productoId),
      'loteId': serializer.toJson<int?>(loteId),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
      'estado': serializer.toJson<String>(estado),
    };
  }

  Alerta copyWith(
          {int? id,
          String? tipo,
          int? productoId,
          Value<int?> loteId = const Value.absent(),
          DateTime? fechaCreacion,
          String? estado}) =>
      Alerta(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        productoId: productoId ?? this.productoId,
        loteId: loteId.present ? loteId.value : this.loteId,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        estado: estado ?? this.estado,
      );
  Alerta copyWithCompanion(AlertasCompanion data) {
    return Alerta(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      productoId:
          data.productoId.present ? data.productoId.value : this.productoId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Alerta(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('productoId: $productoId, ')
          ..write('loteId: $loteId, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tipo, productoId, loteId, fechaCreacion, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alerta &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.productoId == this.productoId &&
          other.loteId == this.loteId &&
          other.fechaCreacion == this.fechaCreacion &&
          other.estado == this.estado);
}

class AlertasCompanion extends UpdateCompanion<Alerta> {
  final Value<int> id;
  final Value<String> tipo;
  final Value<int> productoId;
  final Value<int?> loteId;
  final Value<DateTime> fechaCreacion;
  final Value<String> estado;
  const AlertasCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.productoId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.estado = const Value.absent(),
  });
  AlertasCompanion.insert({
    this.id = const Value.absent(),
    required String tipo,
    required int productoId,
    this.loteId = const Value.absent(),
    required DateTime fechaCreacion,
    this.estado = const Value.absent(),
  })  : tipo = Value(tipo),
        productoId = Value(productoId),
        fechaCreacion = Value(fechaCreacion);
  static Insertable<Alerta> custom({
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<int>? productoId,
    Expression<int>? loteId,
    Expression<DateTime>? fechaCreacion,
    Expression<String>? estado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (productoId != null) 'producto_id': productoId,
      if (loteId != null) 'lote_id': loteId,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (estado != null) 'estado': estado,
    });
  }

  AlertasCompanion copyWith(
      {Value<int>? id,
      Value<String>? tipo,
      Value<int>? productoId,
      Value<int?>? loteId,
      Value<DateTime>? fechaCreacion,
      Value<String>? estado}) {
    return AlertasCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      productoId: productoId ?? this.productoId,
      loteId: loteId ?? this.loteId,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<int>(loteId.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlertasCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('productoId: $productoId, ')
          ..write('loteId: $loteId, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $ConfiguracionesTable extends Configuraciones
    with TableInfo<$ConfiguracionesTable, Configuracione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfiguracionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
      'clave', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
      'valor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, clave, valor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuraciones';
  @override
  VerificationContext validateIntegrity(Insertable<Configuracione> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('clave')) {
      context.handle(
          _claveMeta, clave.isAcceptableOrUnknown(data['clave']!, _claveMeta));
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Configuracione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Configuracione(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clave: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clave'])!,
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}valor'])!,
    );
  }

  @override
  $ConfiguracionesTable createAlias(String alias) {
    return $ConfiguracionesTable(attachedDatabase, alias);
  }
}

class Configuracione extends DataClass implements Insertable<Configuracione> {
  final int id;
  final String clave;
  final String valor;
  const Configuracione(
      {required this.id, required this.clave, required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    return map;
  }

  ConfiguracionesCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionesCompanion(
      id: Value(id),
      clave: Value(clave),
      valor: Value(valor),
    );
  }

  factory Configuracione.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Configuracione(
      id: serializer.fromJson<int>(json['id']),
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
    };
  }

  Configuracione copyWith({int? id, String? clave, String? valor}) =>
      Configuracione(
        id: id ?? this.id,
        clave: clave ?? this.clave,
        valor: valor ?? this.valor,
      );
  Configuracione copyWithCompanion(ConfiguracionesCompanion data) {
    return Configuracione(
      id: data.id.present ? data.id.value : this.id,
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Configuracione(')
          ..write('id: $id, ')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clave, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Configuracione &&
          other.id == this.id &&
          other.clave == this.clave &&
          other.valor == this.valor);
}

class ConfiguracionesCompanion extends UpdateCompanion<Configuracione> {
  final Value<int> id;
  final Value<String> clave;
  final Value<String> valor;
  const ConfiguracionesCompanion({
    this.id = const Value.absent(),
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
  });
  ConfiguracionesCompanion.insert({
    this.id = const Value.absent(),
    required String clave,
    required String valor,
  })  : clave = Value(clave),
        valor = Value(valor);
  static Insertable<Configuracione> custom({
    Expression<int>? id,
    Expression<String>? clave,
    Expression<String>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
    });
  }

  ConfiguracionesCompanion copyWith(
      {Value<int>? id, Value<String>? clave, Value<String>? valor}) {
    return ConfiguracionesCompanion(
      id: id ?? this.id,
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionesCompanion(')
          ..write('id: $id, ')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $ProductosTable productos = $ProductosTable(this);
  late final $LotesTable lotes = $LotesTable(this);
  late final $SintomasTable sintomas = $SintomasTable(this);
  late final $ProductoSintomasTable productoSintomas =
      $ProductoSintomasTable(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $RecetasTable recetas = $RecetasTable(this);
  late final $DetalleRecetasTable detalleRecetas = $DetalleRecetasTable(this);
  late final $VentasTable ventas = $VentasTable(this);
  late final $DetalleVentasTable detalleVentas = $DetalleVentasTable(this);
  late final $AlertasTable alertas = $AlertasTable(this);
  late final $ConfiguracionesTable configuraciones =
      $ConfiguracionesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        usuarios,
        categorias,
        productos,
        lotes,
        sintomas,
        productoSintomas,
        clientes,
        recetas,
        detalleRecetas,
        ventas,
        detalleVentas,
        alertas,
        configuraciones
      ];
}

typedef $$UsuariosTableCreateCompanionBuilder = UsuariosCompanion Function({
  Value<int> id,
  required String username,
  required String password,
  required String rol,
  Value<String?> email,
});
typedef $$UsuariosTableUpdateCompanionBuilder = UsuariosCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> password,
  Value<String> rol,
  Value<String?> email,
});

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VentasTable, List<Venta>> _ventasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ventas,
          aliasName: $_aliasNameGenerator(db.usuarios.id, db.ventas.usuarioId));

  $$VentasTableProcessedTableManager get ventasRefs {
    final manager = $$VentasTableTableManager($_db, $_db.ventas)
        .filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ventasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  Expression<bool> ventasRefs(
      Expression<bool> Function($$VentasTableFilterComposer f) f) {
    final $$VentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.usuarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableFilterComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  Expression<T> ventasRefs<T extends Object>(
      Expression<T> Function($$VentasTableAnnotationComposer a) f) {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.usuarioId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableAnnotationComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsuariosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuariosTable,
    Usuario,
    $$UsuariosTableFilterComposer,
    $$UsuariosTableOrderingComposer,
    $$UsuariosTableAnnotationComposer,
    $$UsuariosTableCreateCompanionBuilder,
    $$UsuariosTableUpdateCompanionBuilder,
    (Usuario, $$UsuariosTableReferences),
    Usuario,
    PrefetchHooks Function({bool ventasRefs})> {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<String> rol = const Value.absent(),
            Value<String?> email = const Value.absent(),
          }) =>
              UsuariosCompanion(
            id: id,
            username: username,
            password: password,
            rol: rol,
            email: email,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String password,
            required String rol,
            Value<String?> email = const Value.absent(),
          }) =>
              UsuariosCompanion.insert(
            id: id,
            username: username,
            password: password,
            rol: rol,
            email: email,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsuariosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({ventasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ventasRefs) db.ventas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ventasRefs)
                    await $_getPrefetchedData<Usuario, $UsuariosTable, Venta>(
                        currentTable: table,
                        referencedTable:
                            $$UsuariosTableReferences._ventasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsuariosTableReferences(db, table, p0).ventasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.usuarioId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsuariosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsuariosTable,
    Usuario,
    $$UsuariosTableFilterComposer,
    $$UsuariosTableOrderingComposer,
    $$UsuariosTableAnnotationComposer,
    $$UsuariosTableCreateCompanionBuilder,
    $$UsuariosTableUpdateCompanionBuilder,
    (Usuario, $$UsuariosTableReferences),
    Usuario,
    PrefetchHooks Function({bool ventasRefs})>;
typedef $$CategoriasTableCreateCompanionBuilder = CategoriasCompanion Function({
  Value<int> id,
  required String nombre,
  Value<int?> padreId,
});
typedef $$CategoriasTableUpdateCompanionBuilder = CategoriasCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<int?> padreId,
});

final class $$CategoriasTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriasTable, Categoria> {
  $$CategoriasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _padreIdTable(_$AppDatabase db) =>
      db.categorias.createAlias(
          $_aliasNameGenerator(db.categorias.padreId, db.categorias.id));

  $$CategoriasTableProcessedTableManager? get padreId {
    final $_column = $_itemColumn<int>('padre_id');
    if ($_column == null) return null;
    final manager = $$CategoriasTableTableManager($_db, $_db.categorias)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_padreIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ProductosTable, List<Producto>>
      _productosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.productos,
          aliasName:
              $_aliasNameGenerator(db.categorias.id, db.productos.categoriaId));

  $$ProductosTableProcessedTableManager get productosRefs {
    final manager = $$ProductosTableTableManager($_db, $_db.productos)
        .filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriasTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  $$CategoriasTableFilterComposer get padreId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.padreId,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableFilterComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> productosRefs(
      Expression<bool> Function($$ProductosTableFilterComposer f) f) {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.categoriaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableFilterComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  $$CategoriasTableOrderingComposer get padreId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.padreId,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableOrderingComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get padreId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.padreId,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableAnnotationComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> productosRefs<T extends Object>(
      Expression<T> Function($$ProductosTableAnnotationComposer a) f) {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.categoriaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableAnnotationComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriasTable,
    Categoria,
    $$CategoriasTableFilterComposer,
    $$CategoriasTableOrderingComposer,
    $$CategoriasTableAnnotationComposer,
    $$CategoriasTableCreateCompanionBuilder,
    $$CategoriasTableUpdateCompanionBuilder,
    (Categoria, $$CategoriasTableReferences),
    Categoria,
    PrefetchHooks Function({bool padreId, bool productosRefs})> {
  $$CategoriasTableTableManager(_$AppDatabase db, $CategoriasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<int?> padreId = const Value.absent(),
          }) =>
              CategoriasCompanion(
            id: id,
            nombre: nombre,
            padreId: padreId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            Value<int?> padreId = const Value.absent(),
          }) =>
              CategoriasCompanion.insert(
            id: id,
            nombre: nombre,
            padreId: padreId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({padreId = false, productosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productosRefs) db.productos],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (padreId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.padreId,
                    referencedTable:
                        $$CategoriasTableReferences._padreIdTable(db),
                    referencedColumn:
                        $$CategoriasTableReferences._padreIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productosRefs)
                    await $_getPrefetchedData<Categoria, $CategoriasTable,
                            Producto>(
                        currentTable: table,
                        referencedTable:
                            $$CategoriasTableReferences._productosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriasTableReferences(db, table, p0)
                                .productosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoriaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriasTable,
    Categoria,
    $$CategoriasTableFilterComposer,
    $$CategoriasTableOrderingComposer,
    $$CategoriasTableAnnotationComposer,
    $$CategoriasTableCreateCompanionBuilder,
    $$CategoriasTableUpdateCompanionBuilder,
    (Categoria, $$CategoriasTableReferences),
    Categoria,
    PrefetchHooks Function({bool padreId, bool productosRefs})>;
typedef $$ProductosTableCreateCompanionBuilder = ProductosCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String?> principioActivo,
  Value<String?> laboratorio,
  Value<String?> presentacion,
  Value<String?> codigoBarras,
  Value<bool> requiereReceta,
  required double precioVenta,
  Value<int> stockMinimo,
  Value<int?> categoriaId,
});
typedef $$ProductosTableUpdateCompanionBuilder = ProductosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String?> principioActivo,
  Value<String?> laboratorio,
  Value<String?> presentacion,
  Value<String?> codigoBarras,
  Value<bool> requiereReceta,
  Value<double> precioVenta,
  Value<int> stockMinimo,
  Value<int?> categoriaId,
});

final class $$ProductosTableReferences
    extends BaseReferences<_$AppDatabase, $ProductosTable, Producto> {
  $$ProductosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _categoriaIdTable(_$AppDatabase db) =>
      db.categorias.createAlias(
          $_aliasNameGenerator(db.productos.categoriaId, db.categorias.id));

  $$CategoriasTableProcessedTableManager? get categoriaId {
    final $_column = $_itemColumn<int>('categoria_id');
    if ($_column == null) return null;
    final manager = $$CategoriasTableTableManager($_db, $_db.categorias)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LotesTable, List<Lote>> _lotesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.lotes,
          aliasName:
              $_aliasNameGenerator(db.productos.id, db.lotes.productoId));

  $$LotesTableProcessedTableManager get lotesRefs {
    final manager = $$LotesTableTableManager($_db, $_db.lotes)
        .filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lotesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProductoSintomasTable, List<ProductoSintoma>>
      _productoSintomasRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.productoSintomas,
              aliasName: $_aliasNameGenerator(
                  db.productos.id, db.productoSintomas.productoId));

  $$ProductoSintomasTableProcessedTableManager get productoSintomasRefs {
    final manager =
        $$ProductoSintomasTableTableManager($_db, $_db.productoSintomas)
            .filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productoSintomasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DetalleRecetasTable, List<DetalleReceta>>
      _detalleRecetasRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.detalleRecetas,
              aliasName: $_aliasNameGenerator(
                  db.productos.id, db.detalleRecetas.productoId));

  $$DetalleRecetasTableProcessedTableManager get detalleRecetasRefs {
    final manager = $$DetalleRecetasTableTableManager($_db, $_db.detalleRecetas)
        .filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_detalleRecetasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AlertasTable, List<Alerta>> _alertasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.alertas,
          aliasName:
              $_aliasNameGenerator(db.productos.id, db.alertas.productoId));

  $$AlertasTableProcessedTableManager get alertasRefs {
    final manager = $$AlertasTableTableManager($_db, $_db.alertas)
        .filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_alertasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductosTableFilterComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get principioActivo => $composableBuilder(
      column: $table.principioActivo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get laboratorio => $composableBuilder(
      column: $table.laboratorio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get presentacion => $composableBuilder(
      column: $table.presentacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get requiereReceta => $composableBuilder(
      column: $table.requiereReceta,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precioVenta => $composableBuilder(
      column: $table.precioVenta, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnFilters(column));

  $$CategoriasTableFilterComposer get categoriaId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoriaId,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableFilterComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> lotesRefs(
      Expression<bool> Function($$LotesTableFilterComposer f) f) {
    final $$LotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableFilterComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> productoSintomasRefs(
      Expression<bool> Function($$ProductoSintomasTableFilterComposer f) f) {
    final $$ProductoSintomasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productoSintomas,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductoSintomasTableFilterComposer(
              $db: $db,
              $table: $db.productoSintomas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> detalleRecetasRefs(
      Expression<bool> Function($$DetalleRecetasTableFilterComposer f) f) {
    final $$DetalleRecetasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleRecetas,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleRecetasTableFilterComposer(
              $db: $db,
              $table: $db.detalleRecetas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> alertasRefs(
      Expression<bool> Function($$AlertasTableFilterComposer f) f) {
    final $$AlertasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alertas,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlertasTableFilterComposer(
              $db: $db,
              $table: $db.alertas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get principioActivo => $composableBuilder(
      column: $table.principioActivo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get laboratorio => $composableBuilder(
      column: $table.laboratorio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get presentacion => $composableBuilder(
      column: $table.presentacion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get requiereReceta => $composableBuilder(
      column: $table.requiereReceta,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precioVenta => $composableBuilder(
      column: $table.precioVenta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => ColumnOrderings(column));

  $$CategoriasTableOrderingComposer get categoriaId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoriaId,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableOrderingComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get principioActivo => $composableBuilder(
      column: $table.principioActivo, builder: (column) => column);

  GeneratedColumn<String> get laboratorio => $composableBuilder(
      column: $table.laboratorio, builder: (column) => column);

  GeneratedColumn<String> get presentacion => $composableBuilder(
      column: $table.presentacion, builder: (column) => column);

  GeneratedColumn<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras, builder: (column) => column);

  GeneratedColumn<bool> get requiereReceta => $composableBuilder(
      column: $table.requiereReceta, builder: (column) => column);

  GeneratedColumn<double> get precioVenta => $composableBuilder(
      column: $table.precioVenta, builder: (column) => column);

  GeneratedColumn<int> get stockMinimo => $composableBuilder(
      column: $table.stockMinimo, builder: (column) => column);

  $$CategoriasTableAnnotationComposer get categoriaId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoriaId,
        referencedTable: $db.categorias,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriasTableAnnotationComposer(
              $db: $db,
              $table: $db.categorias,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> lotesRefs<T extends Object>(
      Expression<T> Function($$LotesTableAnnotationComposer a) f) {
    final $$LotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableAnnotationComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> productoSintomasRefs<T extends Object>(
      Expression<T> Function($$ProductoSintomasTableAnnotationComposer a) f) {
    final $$ProductoSintomasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productoSintomas,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductoSintomasTableAnnotationComposer(
              $db: $db,
              $table: $db.productoSintomas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> detalleRecetasRefs<T extends Object>(
      Expression<T> Function($$DetalleRecetasTableAnnotationComposer a) f) {
    final $$DetalleRecetasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleRecetas,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleRecetasTableAnnotationComposer(
              $db: $db,
              $table: $db.detalleRecetas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> alertasRefs<T extends Object>(
      Expression<T> Function($$AlertasTableAnnotationComposer a) f) {
    final $$AlertasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alertas,
        getReferencedColumn: (t) => t.productoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlertasTableAnnotationComposer(
              $db: $db,
              $table: $db.alertas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductosTable,
    Producto,
    $$ProductosTableFilterComposer,
    $$ProductosTableOrderingComposer,
    $$ProductosTableAnnotationComposer,
    $$ProductosTableCreateCompanionBuilder,
    $$ProductosTableUpdateCompanionBuilder,
    (Producto, $$ProductosTableReferences),
    Producto,
    PrefetchHooks Function(
        {bool categoriaId,
        bool lotesRefs,
        bool productoSintomasRefs,
        bool detalleRecetasRefs,
        bool alertasRefs})> {
  $$ProductosTableTableManager(_$AppDatabase db, $ProductosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String?> principioActivo = const Value.absent(),
            Value<String?> laboratorio = const Value.absent(),
            Value<String?> presentacion = const Value.absent(),
            Value<String?> codigoBarras = const Value.absent(),
            Value<bool> requiereReceta = const Value.absent(),
            Value<double> precioVenta = const Value.absent(),
            Value<int> stockMinimo = const Value.absent(),
            Value<int?> categoriaId = const Value.absent(),
          }) =>
              ProductosCompanion(
            id: id,
            nombre: nombre,
            principioActivo: principioActivo,
            laboratorio: laboratorio,
            presentacion: presentacion,
            codigoBarras: codigoBarras,
            requiereReceta: requiereReceta,
            precioVenta: precioVenta,
            stockMinimo: stockMinimo,
            categoriaId: categoriaId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            Value<String?> principioActivo = const Value.absent(),
            Value<String?> laboratorio = const Value.absent(),
            Value<String?> presentacion = const Value.absent(),
            Value<String?> codigoBarras = const Value.absent(),
            Value<bool> requiereReceta = const Value.absent(),
            required double precioVenta,
            Value<int> stockMinimo = const Value.absent(),
            Value<int?> categoriaId = const Value.absent(),
          }) =>
              ProductosCompanion.insert(
            id: id,
            nombre: nombre,
            principioActivo: principioActivo,
            laboratorio: laboratorio,
            presentacion: presentacion,
            codigoBarras: codigoBarras,
            requiereReceta: requiereReceta,
            precioVenta: precioVenta,
            stockMinimo: stockMinimo,
            categoriaId: categoriaId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {categoriaId = false,
              lotesRefs = false,
              productoSintomasRefs = false,
              detalleRecetasRefs = false,
              alertasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (lotesRefs) db.lotes,
                if (productoSintomasRefs) db.productoSintomas,
                if (detalleRecetasRefs) db.detalleRecetas,
                if (alertasRefs) db.alertas
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoriaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoriaId,
                    referencedTable:
                        $$ProductosTableReferences._categoriaIdTable(db),
                    referencedColumn:
                        $$ProductosTableReferences._categoriaIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lotesRefs)
                    await $_getPrefetchedData<Producto, $ProductosTable, Lote>(
                        currentTable: table,
                        referencedTable:
                            $$ProductosTableReferences._lotesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductosTableReferences(db, table, p0).lotesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productoId == item.id),
                        typedResults: items),
                  if (productoSintomasRefs)
                    await $_getPrefetchedData<Producto, $ProductosTable,
                            ProductoSintoma>(
                        currentTable: table,
                        referencedTable: $$ProductosTableReferences
                            ._productoSintomasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductosTableReferences(db, table, p0)
                                .productoSintomasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productoId == item.id),
                        typedResults: items),
                  if (detalleRecetasRefs)
                    await $_getPrefetchedData<Producto, $ProductosTable,
                            DetalleReceta>(
                        currentTable: table,
                        referencedTable: $$ProductosTableReferences
                            ._detalleRecetasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductosTableReferences(db, table, p0)
                                .detalleRecetasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productoId == item.id),
                        typedResults: items),
                  if (alertasRefs)
                    await $_getPrefetchedData<Producto, $ProductosTable,
                            Alerta>(
                        currentTable: table,
                        referencedTable:
                            $$ProductosTableReferences._alertasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductosTableReferences(db, table, p0)
                                .alertasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductosTable,
    Producto,
    $$ProductosTableFilterComposer,
    $$ProductosTableOrderingComposer,
    $$ProductosTableAnnotationComposer,
    $$ProductosTableCreateCompanionBuilder,
    $$ProductosTableUpdateCompanionBuilder,
    (Producto, $$ProductosTableReferences),
    Producto,
    PrefetchHooks Function(
        {bool categoriaId,
        bool lotesRefs,
        bool productoSintomasRefs,
        bool detalleRecetasRefs,
        bool alertasRefs})>;
typedef $$LotesTableCreateCompanionBuilder = LotesCompanion Function({
  Value<int> id,
  required int productoId,
  Value<String?> numeroLote,
  Value<DateTime?> fechaVencimiento,
  required int cantidadActual,
  Value<double?> costoUnitario,
});
typedef $$LotesTableUpdateCompanionBuilder = LotesCompanion Function({
  Value<int> id,
  Value<int> productoId,
  Value<String?> numeroLote,
  Value<DateTime?> fechaVencimiento,
  Value<int> cantidadActual,
  Value<double?> costoUnitario,
});

final class $$LotesTableReferences
    extends BaseReferences<_$AppDatabase, $LotesTable, Lote> {
  $$LotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductosTable _productoIdTable(_$AppDatabase db) => db.productos
      .createAlias($_aliasNameGenerator(db.lotes.productoId, db.productos.id));

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager($_db, $_db.productos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DetalleVentasTable, List<DetalleVenta>>
      _detalleVentasRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.detalleVentas,
              aliasName:
                  $_aliasNameGenerator(db.lotes.id, db.detalleVentas.loteId));

  $$DetalleVentasTableProcessedTableManager get detalleVentasRefs {
    final manager = $$DetalleVentasTableTableManager($_db, $_db.detalleVentas)
        .filter((f) => f.loteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_detalleVentasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AlertasTable, List<Alerta>> _alertasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.alertas,
          aliasName: $_aliasNameGenerator(db.lotes.id, db.alertas.loteId));

  $$AlertasTableProcessedTableManager get alertasRefs {
    final manager = $$AlertasTableTableManager($_db, $_db.alertas)
        .filter((f) => f.loteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_alertasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LotesTableFilterComposer extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numeroLote => $composableBuilder(
      column: $table.numeroLote, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costoUnitario => $composableBuilder(
      column: $table.costoUnitario, builder: (column) => ColumnFilters(column));

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableFilterComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> detalleVentasRefs(
      Expression<bool> Function($$DetalleVentasTableFilterComposer f) f) {
    final $$DetalleVentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleVentas,
        getReferencedColumn: (t) => t.loteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleVentasTableFilterComposer(
              $db: $db,
              $table: $db.detalleVentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> alertasRefs(
      Expression<bool> Function($$AlertasTableFilterComposer f) f) {
    final $$AlertasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alertas,
        getReferencedColumn: (t) => t.loteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlertasTableFilterComposer(
              $db: $db,
              $table: $db.alertas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LotesTableOrderingComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numeroLote => $composableBuilder(
      column: $table.numeroLote, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costoUnitario => $composableBuilder(
      column: $table.costoUnitario,
      builder: (column) => ColumnOrderings(column));

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableOrderingComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get numeroLote => $composableBuilder(
      column: $table.numeroLote, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento, builder: (column) => column);

  GeneratedColumn<int> get cantidadActual => $composableBuilder(
      column: $table.cantidadActual, builder: (column) => column);

  GeneratedColumn<double> get costoUnitario => $composableBuilder(
      column: $table.costoUnitario, builder: (column) => column);

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableAnnotationComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> detalleVentasRefs<T extends Object>(
      Expression<T> Function($$DetalleVentasTableAnnotationComposer a) f) {
    final $$DetalleVentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleVentas,
        getReferencedColumn: (t) => t.loteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleVentasTableAnnotationComposer(
              $db: $db,
              $table: $db.detalleVentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> alertasRefs<T extends Object>(
      Expression<T> Function($$AlertasTableAnnotationComposer a) f) {
    final $$AlertasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.alertas,
        getReferencedColumn: (t) => t.loteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlertasTableAnnotationComposer(
              $db: $db,
              $table: $db.alertas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LotesTable,
    Lote,
    $$LotesTableFilterComposer,
    $$LotesTableOrderingComposer,
    $$LotesTableAnnotationComposer,
    $$LotesTableCreateCompanionBuilder,
    $$LotesTableUpdateCompanionBuilder,
    (Lote, $$LotesTableReferences),
    Lote,
    PrefetchHooks Function(
        {bool productoId, bool detalleVentasRefs, bool alertasRefs})> {
  $$LotesTableTableManager(_$AppDatabase db, $LotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> productoId = const Value.absent(),
            Value<String?> numeroLote = const Value.absent(),
            Value<DateTime?> fechaVencimiento = const Value.absent(),
            Value<int> cantidadActual = const Value.absent(),
            Value<double?> costoUnitario = const Value.absent(),
          }) =>
              LotesCompanion(
            id: id,
            productoId: productoId,
            numeroLote: numeroLote,
            fechaVencimiento: fechaVencimiento,
            cantidadActual: cantidadActual,
            costoUnitario: costoUnitario,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int productoId,
            Value<String?> numeroLote = const Value.absent(),
            Value<DateTime?> fechaVencimiento = const Value.absent(),
            required int cantidadActual,
            Value<double?> costoUnitario = const Value.absent(),
          }) =>
              LotesCompanion.insert(
            id: id,
            productoId: productoId,
            numeroLote: numeroLote,
            fechaVencimiento: fechaVencimiento,
            cantidadActual: cantidadActual,
            costoUnitario: costoUnitario,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LotesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {productoId = false,
              detalleVentasRefs = false,
              alertasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (detalleVentasRefs) db.detalleVentas,
                if (alertasRefs) db.alertas
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (productoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productoId,
                    referencedTable:
                        $$LotesTableReferences._productoIdTable(db),
                    referencedColumn:
                        $$LotesTableReferences._productoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (detalleVentasRefs)
                    await $_getPrefetchedData<Lote, $LotesTable, DetalleVenta>(
                        currentTable: table,
                        referencedTable:
                            $$LotesTableReferences._detalleVentasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LotesTableReferences(db, table, p0)
                                .detalleVentasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.loteId == item.id),
                        typedResults: items),
                  if (alertasRefs)
                    await $_getPrefetchedData<Lote, $LotesTable, Alerta>(
                        currentTable: table,
                        referencedTable:
                            $$LotesTableReferences._alertasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LotesTableReferences(db, table, p0).alertasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.loteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LotesTable,
    Lote,
    $$LotesTableFilterComposer,
    $$LotesTableOrderingComposer,
    $$LotesTableAnnotationComposer,
    $$LotesTableCreateCompanionBuilder,
    $$LotesTableUpdateCompanionBuilder,
    (Lote, $$LotesTableReferences),
    Lote,
    PrefetchHooks Function(
        {bool productoId, bool detalleVentasRefs, bool alertasRefs})>;
typedef $$SintomasTableCreateCompanionBuilder = SintomasCompanion Function({
  Value<int> id,
  required String nombre,
});
typedef $$SintomasTableUpdateCompanionBuilder = SintomasCompanion Function({
  Value<int> id,
  Value<String> nombre,
});

final class $$SintomasTableReferences
    extends BaseReferences<_$AppDatabase, $SintomasTable, Sintoma> {
  $$SintomasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductoSintomasTable, List<ProductoSintoma>>
      _productoSintomasRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.productoSintomas,
              aliasName: $_aliasNameGenerator(
                  db.sintomas.id, db.productoSintomas.sintomaId));

  $$ProductoSintomasTableProcessedTableManager get productoSintomasRefs {
    final manager =
        $$ProductoSintomasTableTableManager($_db, $_db.productoSintomas)
            .filter((f) => f.sintomaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_productoSintomasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SintomasTableFilterComposer
    extends Composer<_$AppDatabase, $SintomasTable> {
  $$SintomasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  Expression<bool> productoSintomasRefs(
      Expression<bool> Function($$ProductoSintomasTableFilterComposer f) f) {
    final $$ProductoSintomasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productoSintomas,
        getReferencedColumn: (t) => t.sintomaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductoSintomasTableFilterComposer(
              $db: $db,
              $table: $db.productoSintomas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SintomasTableOrderingComposer
    extends Composer<_$AppDatabase, $SintomasTable> {
  $$SintomasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));
}

class $$SintomasTableAnnotationComposer
    extends Composer<_$AppDatabase, $SintomasTable> {
  $$SintomasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> productoSintomasRefs<T extends Object>(
      Expression<T> Function($$ProductoSintomasTableAnnotationComposer a) f) {
    final $$ProductoSintomasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.productoSintomas,
        getReferencedColumn: (t) => t.sintomaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductoSintomasTableAnnotationComposer(
              $db: $db,
              $table: $db.productoSintomas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SintomasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SintomasTable,
    Sintoma,
    $$SintomasTableFilterComposer,
    $$SintomasTableOrderingComposer,
    $$SintomasTableAnnotationComposer,
    $$SintomasTableCreateCompanionBuilder,
    $$SintomasTableUpdateCompanionBuilder,
    (Sintoma, $$SintomasTableReferences),
    Sintoma,
    PrefetchHooks Function({bool productoSintomasRefs})> {
  $$SintomasTableTableManager(_$AppDatabase db, $SintomasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SintomasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SintomasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SintomasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
          }) =>
              SintomasCompanion(
            id: id,
            nombre: nombre,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
          }) =>
              SintomasCompanion.insert(
            id: id,
            nombre: nombre,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SintomasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({productoSintomasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productoSintomasRefs) db.productoSintomas
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productoSintomasRefs)
                    await $_getPrefetchedData<Sintoma, $SintomasTable,
                            ProductoSintoma>(
                        currentTable: table,
                        referencedTable: $$SintomasTableReferences
                            ._productoSintomasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SintomasTableReferences(db, table, p0)
                                .productoSintomasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sintomaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SintomasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SintomasTable,
    Sintoma,
    $$SintomasTableFilterComposer,
    $$SintomasTableOrderingComposer,
    $$SintomasTableAnnotationComposer,
    $$SintomasTableCreateCompanionBuilder,
    $$SintomasTableUpdateCompanionBuilder,
    (Sintoma, $$SintomasTableReferences),
    Sintoma,
    PrefetchHooks Function({bool productoSintomasRefs})>;
typedef $$ProductoSintomasTableCreateCompanionBuilder
    = ProductoSintomasCompanion Function({
  required int productoId,
  required int sintomaId,
  Value<int> rowid,
});
typedef $$ProductoSintomasTableUpdateCompanionBuilder
    = ProductoSintomasCompanion Function({
  Value<int> productoId,
  Value<int> sintomaId,
  Value<int> rowid,
});

final class $$ProductoSintomasTableReferences extends BaseReferences<
    _$AppDatabase, $ProductoSintomasTable, ProductoSintoma> {
  $$ProductoSintomasTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias($_aliasNameGenerator(
          db.productoSintomas.productoId, db.productos.id));

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager($_db, $_db.productos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SintomasTable _sintomaIdTable(_$AppDatabase db) =>
      db.sintomas.createAlias(
          $_aliasNameGenerator(db.productoSintomas.sintomaId, db.sintomas.id));

  $$SintomasTableProcessedTableManager get sintomaId {
    final $_column = $_itemColumn<int>('sintoma_id')!;

    final manager = $$SintomasTableTableManager($_db, $_db.sintomas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sintomaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProductoSintomasTableFilterComposer
    extends Composer<_$AppDatabase, $ProductoSintomasTable> {
  $$ProductoSintomasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableFilterComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SintomasTableFilterComposer get sintomaId {
    final $$SintomasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sintomaId,
        referencedTable: $db.sintomas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SintomasTableFilterComposer(
              $db: $db,
              $table: $db.sintomas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductoSintomasTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductoSintomasTable> {
  $$ProductoSintomasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableOrderingComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SintomasTableOrderingComposer get sintomaId {
    final $$SintomasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sintomaId,
        referencedTable: $db.sintomas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SintomasTableOrderingComposer(
              $db: $db,
              $table: $db.sintomas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductoSintomasTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductoSintomasTable> {
  $$ProductoSintomasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableAnnotationComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SintomasTableAnnotationComposer get sintomaId {
    final $$SintomasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sintomaId,
        referencedTable: $db.sintomas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SintomasTableAnnotationComposer(
              $db: $db,
              $table: $db.sintomas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductoSintomasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductoSintomasTable,
    ProductoSintoma,
    $$ProductoSintomasTableFilterComposer,
    $$ProductoSintomasTableOrderingComposer,
    $$ProductoSintomasTableAnnotationComposer,
    $$ProductoSintomasTableCreateCompanionBuilder,
    $$ProductoSintomasTableUpdateCompanionBuilder,
    (ProductoSintoma, $$ProductoSintomasTableReferences),
    ProductoSintoma,
    PrefetchHooks Function({bool productoId, bool sintomaId})> {
  $$ProductoSintomasTableTableManager(
      _$AppDatabase db, $ProductoSintomasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductoSintomasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductoSintomasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductoSintomasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> productoId = const Value.absent(),
            Value<int> sintomaId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductoSintomasCompanion(
            productoId: productoId,
            sintomaId: sintomaId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int productoId,
            required int sintomaId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductoSintomasCompanion.insert(
            productoId: productoId,
            sintomaId: sintomaId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductoSintomasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({productoId = false, sintomaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (productoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productoId,
                    referencedTable:
                        $$ProductoSintomasTableReferences._productoIdTable(db),
                    referencedColumn: $$ProductoSintomasTableReferences
                        ._productoIdTable(db)
                        .id,
                  ) as T;
                }
                if (sintomaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sintomaId,
                    referencedTable:
                        $$ProductoSintomasTableReferences._sintomaIdTable(db),
                    referencedColumn: $$ProductoSintomasTableReferences
                        ._sintomaIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProductoSintomasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductoSintomasTable,
    ProductoSintoma,
    $$ProductoSintomasTableFilterComposer,
    $$ProductoSintomasTableOrderingComposer,
    $$ProductoSintomasTableAnnotationComposer,
    $$ProductoSintomasTableCreateCompanionBuilder,
    $$ProductoSintomasTableUpdateCompanionBuilder,
    (ProductoSintoma, $$ProductoSintomasTableReferences),
    ProductoSintoma,
    PrefetchHooks Function({bool productoId, bool sintomaId})>;
typedef $$ClientesTableCreateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  required String nombre,
  Value<String?> telefono,
  Value<String?> nit,
});
typedef $$ClientesTableUpdateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String?> telefono,
  Value<String?> nit,
});

final class $$ClientesTableReferences
    extends BaseReferences<_$AppDatabase, $ClientesTable, Cliente> {
  $$ClientesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VentasTable, List<Venta>> _ventasRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ventas,
          aliasName: $_aliasNameGenerator(db.clientes.id, db.ventas.clienteId));

  $$VentasTableProcessedTableManager get ventasRefs {
    final manager = $$VentasTableTableManager($_db, $_db.ventas)
        .filter((f) => f.clienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ventasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nit => $composableBuilder(
      column: $table.nit, builder: (column) => ColumnFilters(column));

  Expression<bool> ventasRefs(
      Expression<bool> Function($$VentasTableFilterComposer f) f) {
    final $$VentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableFilterComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nit => $composableBuilder(
      column: $table.nit, builder: (column) => ColumnOrderings(column));
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get nit =>
      $composableBuilder(column: $table.nit, builder: (column) => column);

  Expression<T> ventasRefs<T extends Object>(
      Expression<T> Function($$VentasTableAnnotationComposer a) f) {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableAnnotationComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, $$ClientesTableReferences),
    Cliente,
    PrefetchHooks Function({bool ventasRefs})> {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String?> telefono = const Value.absent(),
            Value<String?> nit = const Value.absent(),
          }) =>
              ClientesCompanion(
            id: id,
            nombre: nombre,
            telefono: telefono,
            nit: nit,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            Value<String?> telefono = const Value.absent(),
            Value<String?> nit = const Value.absent(),
          }) =>
              ClientesCompanion.insert(
            id: id,
            nombre: nombre,
            telefono: telefono,
            nit: nit,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ClientesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({ventasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ventasRefs) db.ventas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ventasRefs)
                    await $_getPrefetchedData<Cliente, $ClientesTable, Venta>(
                        currentTable: table,
                        referencedTable:
                            $$ClientesTableReferences._ventasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientesTableReferences(db, table, p0).ventasRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.clienteId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClientesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, $$ClientesTableReferences),
    Cliente,
    PrefetchHooks Function({bool ventasRefs})>;
typedef $$RecetasTableCreateCompanionBuilder = RecetasCompanion Function({
  Value<int> id,
  required String numero,
  required String paciente,
  Value<String?> medico,
  required DateTime fechaEmision,
  required DateTime fechaVencimiento,
  Value<String> estado,
});
typedef $$RecetasTableUpdateCompanionBuilder = RecetasCompanion Function({
  Value<int> id,
  Value<String> numero,
  Value<String> paciente,
  Value<String?> medico,
  Value<DateTime> fechaEmision,
  Value<DateTime> fechaVencimiento,
  Value<String> estado,
});

final class $$RecetasTableReferences
    extends BaseReferences<_$AppDatabase, $RecetasTable, Receta> {
  $$RecetasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DetalleRecetasTable, List<DetalleReceta>>
      _detalleRecetasRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.detalleRecetas,
              aliasName: $_aliasNameGenerator(
                  db.recetas.id, db.detalleRecetas.recetaId));

  $$DetalleRecetasTableProcessedTableManager get detalleRecetasRefs {
    final manager = $$DetalleRecetasTableTableManager($_db, $_db.detalleRecetas)
        .filter((f) => f.recetaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_detalleRecetasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RecetasTableFilterComposer
    extends Composer<_$AppDatabase, $RecetasTable> {
  $$RecetasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paciente => $composableBuilder(
      column: $table.paciente, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medico => $composableBuilder(
      column: $table.medico, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaEmision => $composableBuilder(
      column: $table.fechaEmision, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  Expression<bool> detalleRecetasRefs(
      Expression<bool> Function($$DetalleRecetasTableFilterComposer f) f) {
    final $$DetalleRecetasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleRecetas,
        getReferencedColumn: (t) => t.recetaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleRecetasTableFilterComposer(
              $db: $db,
              $table: $db.detalleRecetas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RecetasTableOrderingComposer
    extends Composer<_$AppDatabase, $RecetasTable> {
  $$RecetasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numero => $composableBuilder(
      column: $table.numero, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paciente => $composableBuilder(
      column: $table.paciente, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medico => $composableBuilder(
      column: $table.medico, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaEmision => $composableBuilder(
      column: $table.fechaEmision,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));
}

class $$RecetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecetasTable> {
  $$RecetasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get paciente =>
      $composableBuilder(column: $table.paciente, builder: (column) => column);

  GeneratedColumn<String> get medico =>
      $composableBuilder(column: $table.medico, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaEmision => $composableBuilder(
      column: $table.fechaEmision, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaVencimiento => $composableBuilder(
      column: $table.fechaVencimiento, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  Expression<T> detalleRecetasRefs<T extends Object>(
      Expression<T> Function($$DetalleRecetasTableAnnotationComposer a) f) {
    final $$DetalleRecetasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleRecetas,
        getReferencedColumn: (t) => t.recetaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleRecetasTableAnnotationComposer(
              $db: $db,
              $table: $db.detalleRecetas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RecetasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecetasTable,
    Receta,
    $$RecetasTableFilterComposer,
    $$RecetasTableOrderingComposer,
    $$RecetasTableAnnotationComposer,
    $$RecetasTableCreateCompanionBuilder,
    $$RecetasTableUpdateCompanionBuilder,
    (Receta, $$RecetasTableReferences),
    Receta,
    PrefetchHooks Function({bool detalleRecetasRefs})> {
  $$RecetasTableTableManager(_$AppDatabase db, $RecetasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> numero = const Value.absent(),
            Value<String> paciente = const Value.absent(),
            Value<String?> medico = const Value.absent(),
            Value<DateTime> fechaEmision = const Value.absent(),
            Value<DateTime> fechaVencimiento = const Value.absent(),
            Value<String> estado = const Value.absent(),
          }) =>
              RecetasCompanion(
            id: id,
            numero: numero,
            paciente: paciente,
            medico: medico,
            fechaEmision: fechaEmision,
            fechaVencimiento: fechaVencimiento,
            estado: estado,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String numero,
            required String paciente,
            Value<String?> medico = const Value.absent(),
            required DateTime fechaEmision,
            required DateTime fechaVencimiento,
            Value<String> estado = const Value.absent(),
          }) =>
              RecetasCompanion.insert(
            id: id,
            numero: numero,
            paciente: paciente,
            medico: medico,
            fechaEmision: fechaEmision,
            fechaVencimiento: fechaVencimiento,
            estado: estado,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RecetasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({detalleRecetasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (detalleRecetasRefs) db.detalleRecetas
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (detalleRecetasRefs)
                    await $_getPrefetchedData<Receta, $RecetasTable,
                            DetalleReceta>(
                        currentTable: table,
                        referencedTable: $$RecetasTableReferences
                            ._detalleRecetasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RecetasTableReferences(db, table, p0)
                                .detalleRecetasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.recetaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RecetasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecetasTable,
    Receta,
    $$RecetasTableFilterComposer,
    $$RecetasTableOrderingComposer,
    $$RecetasTableAnnotationComposer,
    $$RecetasTableCreateCompanionBuilder,
    $$RecetasTableUpdateCompanionBuilder,
    (Receta, $$RecetasTableReferences),
    Receta,
    PrefetchHooks Function({bool detalleRecetasRefs})>;
typedef $$DetalleRecetasTableCreateCompanionBuilder = DetalleRecetasCompanion
    Function({
  Value<int> id,
  required int recetaId,
  required int productoId,
  required int cantidadAutorizada,
  Value<int> cantidadDispensada,
});
typedef $$DetalleRecetasTableUpdateCompanionBuilder = DetalleRecetasCompanion
    Function({
  Value<int> id,
  Value<int> recetaId,
  Value<int> productoId,
  Value<int> cantidadAutorizada,
  Value<int> cantidadDispensada,
});

final class $$DetalleRecetasTableReferences
    extends BaseReferences<_$AppDatabase, $DetalleRecetasTable, DetalleReceta> {
  $$DetalleRecetasTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $RecetasTable _recetaIdTable(_$AppDatabase db) =>
      db.recetas.createAlias(
          $_aliasNameGenerator(db.detalleRecetas.recetaId, db.recetas.id));

  $$RecetasTableProcessedTableManager get recetaId {
    final $_column = $_itemColumn<int>('receta_id')!;

    final manager = $$RecetasTableTableManager($_db, $_db.recetas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recetaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias(
          $_aliasNameGenerator(db.detalleRecetas.productoId, db.productos.id));

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager($_db, $_db.productos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DetalleRecetasTableFilterComposer
    extends Composer<_$AppDatabase, $DetalleRecetasTable> {
  $$DetalleRecetasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadAutorizada => $composableBuilder(
      column: $table.cantidadAutorizada,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadDispensada => $composableBuilder(
      column: $table.cantidadDispensada,
      builder: (column) => ColumnFilters(column));

  $$RecetasTableFilterComposer get recetaId {
    final $$RecetasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recetaId,
        referencedTable: $db.recetas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecetasTableFilterComposer(
              $db: $db,
              $table: $db.recetas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableFilterComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetalleRecetasTableOrderingComposer
    extends Composer<_$AppDatabase, $DetalleRecetasTable> {
  $$DetalleRecetasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadAutorizada => $composableBuilder(
      column: $table.cantidadAutorizada,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadDispensada => $composableBuilder(
      column: $table.cantidadDispensada,
      builder: (column) => ColumnOrderings(column));

  $$RecetasTableOrderingComposer get recetaId {
    final $$RecetasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recetaId,
        referencedTable: $db.recetas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecetasTableOrderingComposer(
              $db: $db,
              $table: $db.recetas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableOrderingComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetalleRecetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DetalleRecetasTable> {
  $$DetalleRecetasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cantidadAutorizada => $composableBuilder(
      column: $table.cantidadAutorizada, builder: (column) => column);

  GeneratedColumn<int> get cantidadDispensada => $composableBuilder(
      column: $table.cantidadDispensada, builder: (column) => column);

  $$RecetasTableAnnotationComposer get recetaId {
    final $$RecetasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recetaId,
        referencedTable: $db.recetas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RecetasTableAnnotationComposer(
              $db: $db,
              $table: $db.recetas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableAnnotationComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetalleRecetasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DetalleRecetasTable,
    DetalleReceta,
    $$DetalleRecetasTableFilterComposer,
    $$DetalleRecetasTableOrderingComposer,
    $$DetalleRecetasTableAnnotationComposer,
    $$DetalleRecetasTableCreateCompanionBuilder,
    $$DetalleRecetasTableUpdateCompanionBuilder,
    (DetalleReceta, $$DetalleRecetasTableReferences),
    DetalleReceta,
    PrefetchHooks Function({bool recetaId, bool productoId})> {
  $$DetalleRecetasTableTableManager(
      _$AppDatabase db, $DetalleRecetasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetalleRecetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetalleRecetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetalleRecetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> recetaId = const Value.absent(),
            Value<int> productoId = const Value.absent(),
            Value<int> cantidadAutorizada = const Value.absent(),
            Value<int> cantidadDispensada = const Value.absent(),
          }) =>
              DetalleRecetasCompanion(
            id: id,
            recetaId: recetaId,
            productoId: productoId,
            cantidadAutorizada: cantidadAutorizada,
            cantidadDispensada: cantidadDispensada,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int recetaId,
            required int productoId,
            required int cantidadAutorizada,
            Value<int> cantidadDispensada = const Value.absent(),
          }) =>
              DetalleRecetasCompanion.insert(
            id: id,
            recetaId: recetaId,
            productoId: productoId,
            cantidadAutorizada: cantidadAutorizada,
            cantidadDispensada: cantidadDispensada,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DetalleRecetasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({recetaId = false, productoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (recetaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.recetaId,
                    referencedTable:
                        $$DetalleRecetasTableReferences._recetaIdTable(db),
                    referencedColumn:
                        $$DetalleRecetasTableReferences._recetaIdTable(db).id,
                  ) as T;
                }
                if (productoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productoId,
                    referencedTable:
                        $$DetalleRecetasTableReferences._productoIdTable(db),
                    referencedColumn:
                        $$DetalleRecetasTableReferences._productoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DetalleRecetasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DetalleRecetasTable,
    DetalleReceta,
    $$DetalleRecetasTableFilterComposer,
    $$DetalleRecetasTableOrderingComposer,
    $$DetalleRecetasTableAnnotationComposer,
    $$DetalleRecetasTableCreateCompanionBuilder,
    $$DetalleRecetasTableUpdateCompanionBuilder,
    (DetalleReceta, $$DetalleRecetasTableReferences),
    DetalleReceta,
    PrefetchHooks Function({bool recetaId, bool productoId})>;
typedef $$VentasTableCreateCompanionBuilder = VentasCompanion Function({
  Value<int> id,
  required int usuarioId,
  Value<int?> clienteId,
  required DateTime fechaHora,
  required double subtotal,
  required double igv,
  required double total,
  required String metodoPago,
  Value<String> estado,
});
typedef $$VentasTableUpdateCompanionBuilder = VentasCompanion Function({
  Value<int> id,
  Value<int> usuarioId,
  Value<int?> clienteId,
  Value<DateTime> fechaHora,
  Value<double> subtotal,
  Value<double> igv,
  Value<double> total,
  Value<String> metodoPago,
  Value<String> estado,
});

final class $$VentasTableReferences
    extends BaseReferences<_$AppDatabase, $VentasTable, Venta> {
  $$VentasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) => db.usuarios
      .createAlias($_aliasNameGenerator(db.ventas.usuarioId, db.usuarios.id));

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager($_db, $_db.usuarios)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClientesTable _clienteIdTable(_$AppDatabase db) => db.clientes
      .createAlias($_aliasNameGenerator(db.ventas.clienteId, db.clientes.id));

  $$ClientesTableProcessedTableManager? get clienteId {
    final $_column = $_itemColumn<int>('cliente_id');
    if ($_column == null) return null;
    final manager = $$ClientesTableTableManager($_db, $_db.clientes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DetalleVentasTable, List<DetalleVenta>>
      _detalleVentasRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.detalleVentas,
              aliasName:
                  $_aliasNameGenerator(db.ventas.id, db.detalleVentas.ventaId));

  $$DetalleVentasTableProcessedTableManager get detalleVentasRefs {
    final manager = $$DetalleVentasTableTableManager($_db, $_db.detalleVentas)
        .filter((f) => f.ventaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_detalleVentasRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VentasTableFilterComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaHora => $composableBuilder(
      column: $table.fechaHora, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get igv => $composableBuilder(
      column: $table.igv, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metodoPago => $composableBuilder(
      column: $table.metodoPago, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarios,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuariosTableFilterComposer(
              $db: $db,
              $table: $db.usuarios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClientesTableFilterComposer get clienteId {
    final $$ClientesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableFilterComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> detalleVentasRefs(
      Expression<bool> Function($$DetalleVentasTableFilterComposer f) f) {
    final $$DetalleVentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleVentas,
        getReferencedColumn: (t) => t.ventaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleVentasTableFilterComposer(
              $db: $db,
              $table: $db.detalleVentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VentasTableOrderingComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaHora => $composableBuilder(
      column: $table.fechaHora, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get igv => $composableBuilder(
      column: $table.igv, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get total => $composableBuilder(
      column: $table.total, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metodoPago => $composableBuilder(
      column: $table.metodoPago, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarios,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuariosTableOrderingComposer(
              $db: $db,
              $table: $db.usuarios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClientesTableOrderingComposer get clienteId {
    final $$ClientesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableOrderingComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaHora =>
      $composableBuilder(column: $table.fechaHora, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get igv =>
      $composableBuilder(column: $table.igv, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get metodoPago => $composableBuilder(
      column: $table.metodoPago, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.usuarioId,
        referencedTable: $db.usuarios,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsuariosTableAnnotationComposer(
              $db: $db,
              $table: $db.usuarios,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClientesTableAnnotationComposer get clienteId {
    final $$ClientesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableAnnotationComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> detalleVentasRefs<T extends Object>(
      Expression<T> Function($$DetalleVentasTableAnnotationComposer a) f) {
    final $$DetalleVentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.detalleVentas,
        getReferencedColumn: (t) => t.ventaId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DetalleVentasTableAnnotationComposer(
              $db: $db,
              $table: $db.detalleVentas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VentasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VentasTable,
    Venta,
    $$VentasTableFilterComposer,
    $$VentasTableOrderingComposer,
    $$VentasTableAnnotationComposer,
    $$VentasTableCreateCompanionBuilder,
    $$VentasTableUpdateCompanionBuilder,
    (Venta, $$VentasTableReferences),
    Venta,
    PrefetchHooks Function(
        {bool usuarioId, bool clienteId, bool detalleVentasRefs})> {
  $$VentasTableTableManager(_$AppDatabase db, $VentasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> usuarioId = const Value.absent(),
            Value<int?> clienteId = const Value.absent(),
            Value<DateTime> fechaHora = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> igv = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<String> metodoPago = const Value.absent(),
            Value<String> estado = const Value.absent(),
          }) =>
              VentasCompanion(
            id: id,
            usuarioId: usuarioId,
            clienteId: clienteId,
            fechaHora: fechaHora,
            subtotal: subtotal,
            igv: igv,
            total: total,
            metodoPago: metodoPago,
            estado: estado,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int usuarioId,
            Value<int?> clienteId = const Value.absent(),
            required DateTime fechaHora,
            required double subtotal,
            required double igv,
            required double total,
            required String metodoPago,
            Value<String> estado = const Value.absent(),
          }) =>
              VentasCompanion.insert(
            id: id,
            usuarioId: usuarioId,
            clienteId: clienteId,
            fechaHora: fechaHora,
            subtotal: subtotal,
            igv: igv,
            total: total,
            metodoPago: metodoPago,
            estado: estado,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VentasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {usuarioId = false,
              clienteId = false,
              detalleVentasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (detalleVentasRefs) db.detalleVentas
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (usuarioId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.usuarioId,
                    referencedTable:
                        $$VentasTableReferences._usuarioIdTable(db),
                    referencedColumn:
                        $$VentasTableReferences._usuarioIdTable(db).id,
                  ) as T;
                }
                if (clienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clienteId,
                    referencedTable:
                        $$VentasTableReferences._clienteIdTable(db),
                    referencedColumn:
                        $$VentasTableReferences._clienteIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (detalleVentasRefs)
                    await $_getPrefetchedData<Venta, $VentasTable,
                            DetalleVenta>(
                        currentTable: table,
                        referencedTable:
                            $$VentasTableReferences._detalleVentasRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VentasTableReferences(db, table, p0)
                                .detalleVentasRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ventaId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VentasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VentasTable,
    Venta,
    $$VentasTableFilterComposer,
    $$VentasTableOrderingComposer,
    $$VentasTableAnnotationComposer,
    $$VentasTableCreateCompanionBuilder,
    $$VentasTableUpdateCompanionBuilder,
    (Venta, $$VentasTableReferences),
    Venta,
    PrefetchHooks Function(
        {bool usuarioId, bool clienteId, bool detalleVentasRefs})>;
typedef $$DetalleVentasTableCreateCompanionBuilder = DetalleVentasCompanion
    Function({
  Value<int> id,
  required int ventaId,
  required int loteId,
  required int cantidad,
  required double precioUnitario,
});
typedef $$DetalleVentasTableUpdateCompanionBuilder = DetalleVentasCompanion
    Function({
  Value<int> id,
  Value<int> ventaId,
  Value<int> loteId,
  Value<int> cantidad,
  Value<double> precioUnitario,
});

final class $$DetalleVentasTableReferences
    extends BaseReferences<_$AppDatabase, $DetalleVentasTable, DetalleVenta> {
  $$DetalleVentasTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $VentasTable _ventaIdTable(_$AppDatabase db) => db.ventas.createAlias(
      $_aliasNameGenerator(db.detalleVentas.ventaId, db.ventas.id));

  $$VentasTableProcessedTableManager get ventaId {
    final $_column = $_itemColumn<int>('venta_id')!;

    final manager = $$VentasTableTableManager($_db, $_db.ventas)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ventaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LotesTable _loteIdTable(_$AppDatabase db) => db.lotes
      .createAlias($_aliasNameGenerator(db.detalleVentas.loteId, db.lotes.id));

  $$LotesTableProcessedTableManager get loteId {
    final $_column = $_itemColumn<int>('lote_id')!;

    final manager = $$LotesTableTableManager($_db, $_db.lotes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DetalleVentasTableFilterComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario,
      builder: (column) => ColumnFilters(column));

  $$VentasTableFilterComposer get ventaId {
    final $$VentasTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ventaId,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableFilterComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LotesTableFilterComposer get loteId {
    final $$LotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableFilterComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetalleVentasTableOrderingComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario,
      builder: (column) => ColumnOrderings(column));

  $$VentasTableOrderingComposer get ventaId {
    final $$VentasTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ventaId,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableOrderingComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LotesTableOrderingComposer get loteId {
    final $$LotesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableOrderingComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetalleVentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get precioUnitario => $composableBuilder(
      column: $table.precioUnitario, builder: (column) => column);

  $$VentasTableAnnotationComposer get ventaId {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ventaId,
        referencedTable: $db.ventas,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VentasTableAnnotationComposer(
              $db: $db,
              $table: $db.ventas,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LotesTableAnnotationComposer get loteId {
    final $$LotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableAnnotationComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DetalleVentasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DetalleVentasTable,
    DetalleVenta,
    $$DetalleVentasTableFilterComposer,
    $$DetalleVentasTableOrderingComposer,
    $$DetalleVentasTableAnnotationComposer,
    $$DetalleVentasTableCreateCompanionBuilder,
    $$DetalleVentasTableUpdateCompanionBuilder,
    (DetalleVenta, $$DetalleVentasTableReferences),
    DetalleVenta,
    PrefetchHooks Function({bool ventaId, bool loteId})> {
  $$DetalleVentasTableTableManager(_$AppDatabase db, $DetalleVentasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetalleVentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetalleVentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetalleVentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ventaId = const Value.absent(),
            Value<int> loteId = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<double> precioUnitario = const Value.absent(),
          }) =>
              DetalleVentasCompanion(
            id: id,
            ventaId: ventaId,
            loteId: loteId,
            cantidad: cantidad,
            precioUnitario: precioUnitario,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ventaId,
            required int loteId,
            required int cantidad,
            required double precioUnitario,
          }) =>
              DetalleVentasCompanion.insert(
            id: id,
            ventaId: ventaId,
            loteId: loteId,
            cantidad: cantidad,
            precioUnitario: precioUnitario,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DetalleVentasTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ventaId = false, loteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ventaId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ventaId,
                    referencedTable:
                        $$DetalleVentasTableReferences._ventaIdTable(db),
                    referencedColumn:
                        $$DetalleVentasTableReferences._ventaIdTable(db).id,
                  ) as T;
                }
                if (loteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.loteId,
                    referencedTable:
                        $$DetalleVentasTableReferences._loteIdTable(db),
                    referencedColumn:
                        $$DetalleVentasTableReferences._loteIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DetalleVentasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DetalleVentasTable,
    DetalleVenta,
    $$DetalleVentasTableFilterComposer,
    $$DetalleVentasTableOrderingComposer,
    $$DetalleVentasTableAnnotationComposer,
    $$DetalleVentasTableCreateCompanionBuilder,
    $$DetalleVentasTableUpdateCompanionBuilder,
    (DetalleVenta, $$DetalleVentasTableReferences),
    DetalleVenta,
    PrefetchHooks Function({bool ventaId, bool loteId})>;
typedef $$AlertasTableCreateCompanionBuilder = AlertasCompanion Function({
  Value<int> id,
  required String tipo,
  required int productoId,
  Value<int?> loteId,
  required DateTime fechaCreacion,
  Value<String> estado,
});
typedef $$AlertasTableUpdateCompanionBuilder = AlertasCompanion Function({
  Value<int> id,
  Value<String> tipo,
  Value<int> productoId,
  Value<int?> loteId,
  Value<DateTime> fechaCreacion,
  Value<String> estado,
});

final class $$AlertasTableReferences
    extends BaseReferences<_$AppDatabase, $AlertasTable, Alerta> {
  $$AlertasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias(
          $_aliasNameGenerator(db.alertas.productoId, db.productos.id));

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager($_db, $_db.productos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LotesTable _loteIdTable(_$AppDatabase db) => db.lotes
      .createAlias($_aliasNameGenerator(db.alertas.loteId, db.lotes.id));

  $$LotesTableProcessedTableManager? get loteId {
    final $_column = $_itemColumn<int>('lote_id');
    if ($_column == null) return null;
    final manager = $$LotesTableTableManager($_db, $_db.lotes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AlertasTableFilterComposer
    extends Composer<_$AppDatabase, $AlertasTable> {
  $$AlertasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableFilterComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LotesTableFilterComposer get loteId {
    final $$LotesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableFilterComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlertasTableOrderingComposer
    extends Composer<_$AppDatabase, $AlertasTable> {
  $$AlertasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableOrderingComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LotesTableOrderingComposer get loteId {
    final $$LotesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableOrderingComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlertasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlertasTable> {
  $$AlertasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
      column: $table.fechaCreacion, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productoId,
        referencedTable: $db.productos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductosTableAnnotationComposer(
              $db: $db,
              $table: $db.productos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LotesTableAnnotationComposer get loteId {
    final $$LotesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.loteId,
        referencedTable: $db.lotes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LotesTableAnnotationComposer(
              $db: $db,
              $table: $db.lotes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AlertasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlertasTable,
    Alerta,
    $$AlertasTableFilterComposer,
    $$AlertasTableOrderingComposer,
    $$AlertasTableAnnotationComposer,
    $$AlertasTableCreateCompanionBuilder,
    $$AlertasTableUpdateCompanionBuilder,
    (Alerta, $$AlertasTableReferences),
    Alerta,
    PrefetchHooks Function({bool productoId, bool loteId})> {
  $$AlertasTableTableManager(_$AppDatabase db, $AlertasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlertasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlertasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlertasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<int> productoId = const Value.absent(),
            Value<int?> loteId = const Value.absent(),
            Value<DateTime> fechaCreacion = const Value.absent(),
            Value<String> estado = const Value.absent(),
          }) =>
              AlertasCompanion(
            id: id,
            tipo: tipo,
            productoId: productoId,
            loteId: loteId,
            fechaCreacion: fechaCreacion,
            estado: estado,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String tipo,
            required int productoId,
            Value<int?> loteId = const Value.absent(),
            required DateTime fechaCreacion,
            Value<String> estado = const Value.absent(),
          }) =>
              AlertasCompanion.insert(
            id: id,
            tipo: tipo,
            productoId: productoId,
            loteId: loteId,
            fechaCreacion: fechaCreacion,
            estado: estado,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AlertasTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({productoId = false, loteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (productoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productoId,
                    referencedTable:
                        $$AlertasTableReferences._productoIdTable(db),
                    referencedColumn:
                        $$AlertasTableReferences._productoIdTable(db).id,
                  ) as T;
                }
                if (loteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.loteId,
                    referencedTable: $$AlertasTableReferences._loteIdTable(db),
                    referencedColumn:
                        $$AlertasTableReferences._loteIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AlertasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlertasTable,
    Alerta,
    $$AlertasTableFilterComposer,
    $$AlertasTableOrderingComposer,
    $$AlertasTableAnnotationComposer,
    $$AlertasTableCreateCompanionBuilder,
    $$AlertasTableUpdateCompanionBuilder,
    (Alerta, $$AlertasTableReferences),
    Alerta,
    PrefetchHooks Function({bool productoId, bool loteId})>;
typedef $$ConfiguracionesTableCreateCompanionBuilder = ConfiguracionesCompanion
    Function({
  Value<int> id,
  required String clave,
  required String valor,
});
typedef $$ConfiguracionesTableUpdateCompanionBuilder = ConfiguracionesCompanion
    Function({
  Value<int> id,
  Value<String> clave,
  Value<String> valor,
});

class $$ConfiguracionesTableFilterComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnFilters(column));
}

class $$ConfiguracionesTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnOrderings(column));
}

class $$ConfiguracionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);
}

class $$ConfiguracionesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConfiguracionesTable,
    Configuracione,
    $$ConfiguracionesTableFilterComposer,
    $$ConfiguracionesTableOrderingComposer,
    $$ConfiguracionesTableAnnotationComposer,
    $$ConfiguracionesTableCreateCompanionBuilder,
    $$ConfiguracionesTableUpdateCompanionBuilder,
    (
      Configuracione,
      BaseReferences<_$AppDatabase, $ConfiguracionesTable, Configuracione>
    ),
    Configuracione,
    PrefetchHooks Function()> {
  $$ConfiguracionesTableTableManager(
      _$AppDatabase db, $ConfiguracionesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfiguracionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfiguracionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfiguracionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> clave = const Value.absent(),
            Value<String> valor = const Value.absent(),
          }) =>
              ConfiguracionesCompanion(
            id: id,
            clave: clave,
            valor: valor,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String clave,
            required String valor,
          }) =>
              ConfiguracionesCompanion.insert(
            id: id,
            clave: clave,
            valor: valor,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConfiguracionesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConfiguracionesTable,
    Configuracione,
    $$ConfiguracionesTableFilterComposer,
    $$ConfiguracionesTableOrderingComposer,
    $$ConfiguracionesTableAnnotationComposer,
    $$ConfiguracionesTableCreateCompanionBuilder,
    $$ConfiguracionesTableUpdateCompanionBuilder,
    (
      Configuracione,
      BaseReferences<_$AppDatabase, $ConfiguracionesTable, Configuracione>
    ),
    Configuracione,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db, _db.productos);
  $$LotesTableTableManager get lotes =>
      $$LotesTableTableManager(_db, _db.lotes);
  $$SintomasTableTableManager get sintomas =>
      $$SintomasTableTableManager(_db, _db.sintomas);
  $$ProductoSintomasTableTableManager get productoSintomas =>
      $$ProductoSintomasTableTableManager(_db, _db.productoSintomas);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$RecetasTableTableManager get recetas =>
      $$RecetasTableTableManager(_db, _db.recetas);
  $$DetalleRecetasTableTableManager get detalleRecetas =>
      $$DetalleRecetasTableTableManager(_db, _db.detalleRecetas);
  $$VentasTableTableManager get ventas =>
      $$VentasTableTableManager(_db, _db.ventas);
  $$DetalleVentasTableTableManager get detalleVentas =>
      $$DetalleVentasTableTableManager(_db, _db.detalleVentas);
  $$AlertasTableTableManager get alertas =>
      $$AlertasTableTableManager(_db, _db.alertas);
  $$ConfiguracionesTableTableManager get configuraciones =>
      $$ConfiguracionesTableTableManager(_db, _db.configuraciones);
}
