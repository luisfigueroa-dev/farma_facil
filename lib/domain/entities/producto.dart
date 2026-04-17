import 'package:equatable/equatable.dart';

class Producto extends Equatable {
  final int? id;
  final String nombre;
  final String? principioActivo;
  final String? laboratorio;
  final String? presentacion;
  final String? codigoBarras;
  final bool requiereReceta;
  final double precioVenta;
  final int stockMinimo;
  final int? categoriaId;

  const Producto({
    this.id,
    required this.nombre,
    this.principioActivo,
    this.laboratorio,
    this.presentacion,
    this.codigoBarras,
    this.requiereReceta = false,
    required this.precioVenta,
    this.stockMinimo = 0,
    this.categoriaId,
  });

  @override
  List<Object?> get props => [
        id,
        nombre,
        principioActivo,
        laboratorio,
        presentacion,
        codigoBarras,
        requiereReceta,
        precioVenta,
        stockMinimo,
        categoriaId,
      ];

  Producto copyWith({
    int? id,
    String? nombre,
    String? principioActivo,
    String? laboratorio,
    String? presentacion,
    String? codigoBarras,
    bool? requiereReceta,
    double? precioVenta,
    int? stockMinimo,
    int? categoriaId,
  }) {
    return Producto(
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
}