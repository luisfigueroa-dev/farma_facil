import 'package:equatable/equatable.dart';

class Lote extends Equatable {
  final int? id;
  final int productoId;
  final String? numeroLote;
  final DateTime? fechaVencimiento;
  final int cantidadActual;
  final double? costoUnitario;

  const Lote({
    this.id,
    required this.productoId,
    this.numeroLote,
    this.fechaVencimiento,
    required this.cantidadActual,
    this.costoUnitario,
  });

  @override
  List<Object?> get props =>
      [id, productoId, numeroLote, fechaVencimiento, cantidadActual, costoUnitario];

  Lote copyWith({
    int? id,
    int? productoId,
    String? numeroLote,
    DateTime? fechaVencimiento,
    int? cantidadActual,
    double? costoUnitario,
  }) {
    return Lote(
      id: id ?? this.id,
      productoId: productoId ?? this.productoId,
      numeroLote: numeroLote ?? this.numeroLote,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      costoUnitario: costoUnitario ?? this.costoUnitario,
    );
  }
}