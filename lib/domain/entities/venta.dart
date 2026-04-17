import 'package:equatable/equatable.dart';

enum MetodoPago { efectivo, tarjeta, qr }

enum EstadoVenta { pendiente, completada, cancelada }

class Venta extends Equatable {
  final int? id;
  final int? usuarioId;
  final int? clienteId;
  final DateTime fechaHora;
  final double subtotal;
  final double igv;
  final double total;
  final MetodoPago metodoPago;
  final EstadoVenta estado;

  const Venta({
    this.id,
    this.usuarioId,
    this.clienteId,
    required this.fechaHora,
    required this.subtotal,
    required this.igv,
    required this.total,
    required this.metodoPago,
    this.estado = EstadoVenta.completada,
  });

  @override
  List<Object?> get props =>
      [id, usuarioId, clienteId, fechaHora, subtotal, igv, total, metodoPago, estado];

  Venta copyWith({
    int? id,
    int? usuarioId,
    int? clienteId,
    DateTime? fechaHora,
    double? subtotal,
    double? igv,
    double? total,
    MetodoPago? metodoPago,
    EstadoVenta? estado,
  }) {
    return Venta(
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
}

class DetalleVenta extends Equatable {
  final int? id;
  final int ventaId;
  final int loteId;
  final int cantidad;
  final double precioUnitario;

  const DetalleVenta({
    this.id,
    required this.ventaId,
    required this.loteId,
    required this.cantidad,
    required this.precioUnitario,
  });

  @override
  List<Object?> get props => [id, ventaId, loteId, cantidad, precioUnitario];
}

class ItemCarrito extends Equatable {
  final int productoId;
  final String nombreProducto;
  final String? presentacion;
  final int loteId;
  final int cantidad;
  final double precioUnitario;

  const ItemCarrito({
    required this.productoId,
    required this.nombreProducto,
    this.presentacion,
    required this.loteId,
    required this.cantidad,
    required this.precioUnitario,
  });

  double get total => cantidad * precioUnitario;

  @override
  List<Object?> get props =>
      [productoId, nombreProducto, presentacion, loteId, cantidad, precioUnitario];

  ItemCarrito copyWith({
    int? productoId,
    String? nombreProducto,
    String? presentacion,
    int? loteId,
    int? cantidad,
    double? precioUnitario,
  }) {
    return ItemCarrito(
      productoId: productoId ?? this.productoId,
      nombreProducto: nombreProducto ?? this.nombreProducto,
      presentacion: presentacion ?? this.presentacion,
      loteId: loteId ?? this.loteId,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
    );
  }
}