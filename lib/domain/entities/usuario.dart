import 'package:equatable/equatable.dart';

enum RolUsuario { administrador, cajero }

class Usuario extends Equatable {
  final int? id;
  final String username;
  final String password;
  final RolUsuario rol;
  final String? email;

  const Usuario({
    this.id,
    required this.username,
    required this.password,
    required this.rol,
    this.email,
  });

  @override
  List<Object?> get props => [id, username, password, rol, email];

  Usuario copyWith({
    int? id,
    String? username,
    String? password,
    RolUsuario? rol,
    String? email,
  }) {
    return Usuario(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      rol: rol ?? this.rol,
      email: email ?? this.email,
    );
  }
}