import 'package:equatable/equatable.dart';

class Configuracion extends Equatable {
  final int? id;
  final String clave;
  final String valor;

  const Configuracion({
    this.id,
    required this.clave,
    required this.valor,
  });

  @override
  List<Object?> get props => [id, clave, valor];

  static const String keyNombreFarmacia = 'nombre_farmacia';
  static const String keyDireccion = 'direccion';
  static const String keyNit = 'nit';
  static const String keyTelefono = 'telefono';
  static const String keyRutaPdf = 'ruta_pdf';
  static const String keyImpresoraPuerto = 'impresora_puerto';
  static const String keyIvaPorcentaje = 'iva_porcentaje';
}