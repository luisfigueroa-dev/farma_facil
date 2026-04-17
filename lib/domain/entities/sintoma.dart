import 'package:equatable/equatable.dart';

class Sintoma extends Equatable {
  final int? id;
  final String nombre;

  const Sintoma({
    this.id,
    required this.nombre,
  });

  @override
  List<Object?> get props => [id, nombre];

  Sintoma copyWith({
    int? id,
    String? nombre,
  }) {
    return Sintoma(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }
}