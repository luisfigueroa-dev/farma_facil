import 'package:equatable/equatable.dart';

class Categoria extends Equatable {
  final int? id;
  final String nombre;
  final int? padreId;

  const Categoria({
    this.id,
    required this.nombre,
    this.padreId,
  });

  @override
  List<Object?> get props => [id, nombre, padreId];

  Categoria copyWith({
    int? id,
    String? nombre,
    int? padreId,
  }) {
    return Categoria(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      padreId: padreId ?? this.padreId,
    );
  }
}