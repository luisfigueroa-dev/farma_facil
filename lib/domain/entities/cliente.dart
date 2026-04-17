import 'package:equatable/equatable.dart';

class Cliente extends Equatable {
  final int? id;
  final String nombre;
  final String? telefono;
  final String? nit;

  const Cliente({
    this.id,
    required this.nombre,
    this.telefono,
    this.nit,
  });

  @override
  List<Object?> get props => [id, nombre, telefono, nit];

  Cliente copyWith({
    int? id,
    String? nombre,
    String? telefono,
    String? nit,
  }) {
    return Cliente(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      nit: nit ?? this.nit,
    );
  }
}