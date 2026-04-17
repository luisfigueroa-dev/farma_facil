import 'package:equatable/equatable.dart';

enum EstadoReceta { pendiente, dispensada, vencida, cancelada }

class Receta extends Equatable {
  final int? id;
  final String numero;
  final String paciente;
  final String? medico;
  final DateTime fechaEmision;
  final DateTime fechaVencimiento;
  final EstadoReceta estado;

  const Receta({
    this.id,
    required this.numero,
    required this.paciente,
    this.medico,
    required this.fechaEmision,
    required this.fechaVencimiento,
    this.estado = EstadoReceta.pendiente,
  });

  @override
  List<Object?> get props =>
      [id, numero, paciente, medico, fechaEmision, fechaVencimiento, estado];

  Receta copyWith({
    int? id,
    String? numero,
    String? paciente,
    String? medico,
    DateTime? fechaEmision,
    DateTime? fechaVencimiento,
    EstadoReceta? estado,
  }) {
    return Receta(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      paciente: paciente ?? this.paciente,
      medico: medico ?? this.medico,
      fechaEmision: fechaEmision ?? this.fechaEmision,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      estado: estado ?? this.estado,
    );
  }
}

class DetalleReceta extends Equatable {
  final int? id;
  final int recetaId;
  final int productoId;
  final int cantidadAutorizada;
  final int cantidadDispensada;

  const DetalleReceta({
    this.id,
    required this.recetaId,
    required this.productoId,
    required this.cantidadAutorizada,
    this.cantidadDispensada = 0,
  });

  @override
  List<Object?> get props =>
      [id, recetaId, productoId, cantidadAutorizada, cantidadDispensada];
}