import 'dart:typed_data';

class ImpresoraTermicaService {
  static final ImpresoraTermicaService _instance = ImpresoraTermicaService._internal();
  factory ImpresoraTermicaService() => _instance;
  ImpresoraTermicaService._internal();

  bool _estaInicializada = false;
  String _puertoSeleccionado = '';

  bool get estaInicializada => _estaInicializada;
  String get puertoSeleccionado => _puertoSeleccionado;

  List<String> getPuertosDisponibles() {
    final ports = <String>[];
    for (int i = 1; i <= 20; i++) {
      ports.add('COM$i');
    }
    return ports;
  }

  Future<bool> inicializar(String puerto) async {
    _puertoSeleccionado = puerto;
    _estaInicializada = true;
    return true;
  }

  void desconectar() {
    _estaInicializada = false;
    _puertoSeleccionado = '';
  }

  Uint8List _iniciarDocumento() {
    final bytes = <int>[];
    bytes.addAll([0x1B, 0x40]);
    return Uint8List.fromList(bytes);
  }

  Uint8List _centrar() {
    return Uint8List.fromList([0x1B, 0x61, 0x01]);
  }

  Uint8List _izquierda() {
    return Uint8List.fromList([0x1B, 0x61, 0x00]);
  }

  Uint8List _negrita(bool activar) {
    return Uint8List.fromList([0x1B, 0x45, activar ? 0x01 : 0x00]);
  }

  Uint8List _dobleAltura(bool activar) {
    return Uint8List.fromList([0x1B, 0x21, activar ? 0x10 : 0x00]);
  }

  Uint8List _cortar() {
    return Uint8List.fromList([0x1D, 0x56, 0x00]);
  }

  Uint8List _espacio(int lineas) {
    return Uint8List.fromList([0x1B, 0x64, lineas]);
  }

  String _formatearLinea(String texto, int ancho) {
    if (texto.length >= ancho) {
      return texto.substring(0, ancho);
    }
    return texto.padRight(ancho);
  }

  String _formatearMonto(double monto) {
    return 'Bs. ${monto.toStringAsFixed(2)}';
  }

  Future<bool> imprimirTicket({
    required String nombreFarmacia,
    required String direccion,
    required String nit,
    required String telefono,
    required int numeroVenta,
    required DateTime fechaHora,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double igv,
    required double total,
    required String metodoPago,
  }) async {
    if (!_estaInicializada) {
      return false;
    }

    try {
      final datos = BytesBuilder();
      datos.add(_iniciarDocumento());

      datos.add(_centrar());
      datos.add(_negrita(true));
      datos.add(_dobleAltura(true));
      datos.add(_formatearLinea(nombreFarmacia, 40).codeUnits);
      datos.add(_dobleAltura(false));
      datos.add(_negrita(false));
      
      datos.add(_espacio(1));
      datos.add(_izquierda());
      
      if (direccion.isNotEmpty) {
        datos.add(direccion.codeUnits);
        datos.add(_espacio(1));
      }
      if (nit.isNotEmpty) {
        datos.add('NIT: $nit'.codeUnits);
        datos.add(_espacio(1));
      }
      if (telefono.isNotEmpty) {
        datos.add('Tel: $telefono'.codeUnits);
        datos.add(_espacio(1));
      }

      datos.add(_centrar());
      datos.add(_negrita(true));
      datos.add('========================================'.codeUnits);
      datos.add('NOTA DE VENTA'.codeUnits);
      datos.add('========================================'.codeUnits);
      datos.add(_negrita(false));

      datos.add(_espacio(1));
      datos.add(_izquierda());
      datos.add('No. Venta: #$numeroVenta'.codeUnits);
      datos.add(_espacio(1));
      datos.add('Fecha: ${_formatDate(fechaHora)}'.codeUnits);
      datos.add(_espacio(1));
      datos.add('Hora: ${_formatTime(fechaHora)}'.codeUnits);

      datos.add('----------------------------------------'.codeUnits);
      datos.add(_izquierda());
      datos.add(_formatearLinea('Item', 18).codeUnits);
      datos.add(_formatearLinea('Cant', 6).codeUnits);
      datos.add(_formatearLinea('P.Unit', 8).codeUnits);
      datos.add(_formatearLinea('Total', 8).codeUnits);
      datos.add('----------------------------------------'.codeUnits);

      for (final item in items) {
        final nombre = item['nombre'] as String;
        final cantidad = item['cantidad'] as int;
        final precioUnitario = item['precioUnitario'] as double;
        final itemTotal = cantidad * precioUnitario;

        final nombreCortado = nombre.length > 18 ? '${nombre.substring(0, 15)}...' : nombre;
        datos.add(_formatearLinea(nombreCortado, 18).codeUnits);
        datos.add(cantidad.toString().padLeft(6).codeUnits);
        datos.add(precioUnitario.toStringAsFixed(2).padLeft(8).codeUnits);
        datos.add(itemTotal.toStringAsFixed(2).padLeft(8).codeUnits);
      }

      datos.add('----------------------------------------'.codeUnits);
      datos.add(_izquierda());
      
      final subStr = _formatearLinea('SUBTOTAL:', 28);
      datos.add(subStr.codeUnits);
      datos.add(subtotal.toStringAsFixed(2).padLeft(12).codeUnits);
      
      datos.add(_formatearLinea('IVA (13%):', 28).codeUnits);
      datos.add(igv.toStringAsFixed(2).padLeft(12).codeUnits);
      
      datos.add('========================================'.codeUnits);
      datos.add(_centrar());
      datos.add(_negrita(true));
      datos.add('TOTAL:'.codeUnits);
      datos.add(total.toStringAsFixed(2).padLeft(15).codeUnits);
      datos.add(_negrita(false));

      datos.add(_espacio(2));
      datos.add(_izquierda());
      datos.add('Método: ${metodoPago.toUpperCase()}'.codeUnits);

      datos.add(_espacio(3));
      datos.add(_centrar());
      datos.add('Gracias por su preferencia'.codeUnits);
      datos.add(_espacio(3));
      datos.add(_cortar());

      return true;
    } catch (e) {
      return false;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}