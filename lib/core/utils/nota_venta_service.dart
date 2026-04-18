import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../data/datasources/database.dart';

class NotaVentaService {
  final AppDatabase db;

  NotaVentaService(this.db);

  Future<Venta?> getVenta(int ventaId) async {
    final result = await (db.select(db.ventas)
      ..where((t) => t.id.equals(ventaId)))
      .getSingleOrNull();
    return result;
  }

  Future<List<DetalleVenta>> getDetallesVenta(int ventaId) async {
    final results = await (db.select(db.detalleVentas)
      ..where((t) => t.ventaId.equals(ventaId)))
      .get();
    return results;
  }

  Future<Map<String, dynamic>?> getDatosFarmacia() async {
    final results = await db.select(db.configuraciones).get();
    final map = <String, String>{};
    for (final config in results) {
      map[config.clave] = config.valor;
    }
    return map;
  }

  Future<String?> generarPdf(int ventaId) async {
    try {
      final venta = await getVenta(ventaId);
      if (venta == null) return null;

      final detalles = await getDetallesVenta(ventaId);
      final datos = await getDatosFarmacia();

      final pdf = pw.Document();

      final nombreFarmacia = datos?['nombre_farmacia'] ?? 'FarmaFacil';
      final direccion = datos?['direccion'] ?? '';
      final nit = datos?['nit'] ?? '';
      final telefono = datos?['telefono'] ?? '';

      final List<pw.Widget> itemsWidgets = [];
      for (final detalle in detalles) {
        final lote = await (db.select(db.lotes)
          ..where((t) => t.id.equals(detalle.loteId)))
          .getSingleOrNull();
        
        final producto = lote != null 
            ? await (db.select(db.productos)
                ..where((t) => t.id.equals(lote.productoId)))
                .getSingleOrNull()
            : null;

        if (producto != null) {
          itemsWidgets.add(
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      producto.nombre,
                      style: const pw.TextStyle(fontSize: 9),
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    '${detalle.cantidad}',
                    style: const pw.TextStyle(fontSize: 9),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    '${detalle.precioUnitario.toStringAsFixed(2)}',
                    style: const pw.TextStyle(fontSize: 9),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    '${(detalle.cantidad * detalle.precioUnitario).toStringAsFixed(2)}',
                    style: const pw.TextStyle(fontSize: 9),
                  ),
                ],
              ),
            ),
          );
        }
      }

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.roll80,
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                nombreFarmacia,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              if (direccion.isNotEmpty)
                pw.Text(direccion, style: const pw.TextStyle(fontSize: 8)),
              if (nit.isNotEmpty)
                pw.Text('NIT: $nit', style: const pw.TextStyle(fontSize: 8)),
              if (telefono.isNotEmpty)
                pw.Text('Tel: $telefono', style: const pw.TextStyle(fontSize: 8)),
              pw.Divider(thickness: 1),
              pw.Text(
                'NOTA DE VENTA',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'No. ${venta.id}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                'Fecha: ${_formatDate(venta.fechaHora)}',
                style: const pw.TextStyle(fontSize: 9),
              ),
              pw.Text(
                'Hora: ${_formatTime(venta.fechaHora)}',
                style: const pw.TextStyle(fontSize: 9),
              ),
              pw.Divider(thickness: 1),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Item', style: const pw.TextStyle(fontSize: 8)),
                  pw.Text('Cant', style: const pw.TextStyle(fontSize: 8)),
                  pw.Text('P.Unit', style: const pw.TextStyle(fontSize: 8)),
                  pw.Text('Total', style: const pw.TextStyle(fontSize: 8)),
                ],
              ),
              pw.Divider(thickness: 0.5),
              ...itemsWidgets,
              pw.Divider(thickness: 1),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('SUBTOTAL:', style: const pw.TextStyle(fontSize: 9)),
                  pw.Text('Bs. ${venta.subtotal.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('IVA (13%):', style: const pw.TextStyle(fontSize: 9)),
                  pw.Text('Bs. ${venta.igv.toStringAsFixed(2)}', style: const pw.TextStyle(fontSize: 9)),
                ],
              ),
              pw.Divider(thickness: 1),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'TOTAL:',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Bs. ${venta.total.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Método: ${venta.metodoPago.toUpperCase()}',
                style: const pw.TextStyle(fontSize: 9),
              ),
              pw.SizedBox(height: 15),
              pw.Text(
                'Gracias por su preferencia',
                style: const pw.TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      );

      String rutaPdf = datos?['ruta_pdf'] ?? '';
      if (rutaPdf.isEmpty) {
        final docsDir = await getApplicationDocumentsDirectory();
        rutaPdf = p.join(docsDir.path, 'FarmaFacil');
      }

      final dir = Directory(rutaPdf);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = p.join(rutaPdf, 'NotaVenta_${venta.id}_$timestamp.pdf');
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      return filePath;
    } catch (e) {
      return null;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}