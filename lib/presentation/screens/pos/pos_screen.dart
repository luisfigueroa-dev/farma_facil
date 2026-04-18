import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/pos_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/impresora_provider.dart';
import '../../../domain/entities/venta.dart';
import '../../../core/utils/nota_venta_service.dart';

class PosScreen extends ConsumerStatefulWidget {
  const PosScreen({super.key});

  @override
  ConsumerState<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends ConsumerState<PosScreen> {
  final _busquedaController = TextEditingController();
  final _busquedaFocus = FocusNode();
  int? _productoSeleccionadoId;

  @override
  void dispose() {
    _busquedaController.dispose();
    _busquedaFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Punto de Venta (POS)'),
          actions: [
            TextButton.icon(
              onPressed: _nuevaVenta,
              icon: const Icon(Icons.add),
              label: const Text('Nueva (Ctrl+N)'),
            ),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildPanelBusqueda(),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              flex: 2,
              child: _buildPanelCarrito(),
            ),
          ],
        ),
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.f1) {
        _busquedaFocus.requestFocus();
      } else if (event.logicalKey == LogicalKeyboardKey.f4) {
        _finalizarVenta();
      } else if (event.logicalKey == LogicalKeyboardKey.f5) {
        _nuevaVenta();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        _busquedaController.clear();
        _busquedaFocus.unfocus();
      }
    }
  }

  Widget _buildPanelBusqueda() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _busquedaController,
            focusNode: _busquedaFocus,
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, código o principio activo... (F1)',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon: _busquedaController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _busquedaController.clear();
                        setState(() {});
                      },
                    )
                  : null,
            ),
            onChanged: (value) => setState(() {}),
            onSubmitted: (_) => _agregarPrimerProducto(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _busquedaController.text.isEmpty
                ? const Center(
                    child: Text(
                      'Ingrese un término de búsqueda (F1 para enfocar)',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : _buildListaProductos(),
          ),
        ],
      ),
    );
  }

  Widget _buildListaProductos() {
    final query = _busquedaController.text.trim();
    final productosAsync = ref.watch(productosBusquedaProvider(query));

    return productosAsync.when(
      data: (productos) {
        if (productos.isEmpty) {
          return const Center(
            child: Text('No se encontraron productos'),
          );
        }
        return ListView.builder(
          itemCount: productos.length,
          itemBuilder: (context, index) {
            final producto = productos[index];
            final isSelected = _productoSeleccionadoId == producto.id;
            return Card(
              color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(producto.nombre.substring(0, 1).toUpperCase()),
                ),
                title: Text(producto.nombre),
                subtitle: Text(
                  '${producto.principioActivo ?? ''} ${producto.presentacion ?? ''}'.trim(),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (producto.requiereReceta)
                      const Chip(
                        label: Text('Receta', style: TextStyle(fontSize: 10)),
                        padding: EdgeInsets.zero,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      'Bs. ${producto.precioVenta.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () => _seleccionarProducto(producto.id),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  void _seleccionarProducto(int productoId) {
    setState(() {
      _productoSeleccionadoId = productoId;
    });
    _mostrarDialogoCantidad(productoId);
  }

  void _mostrarDialogoCantidad(int productoId) async {
    final query = _busquedaController.text.trim();
    final productos = await ref.read(productosBusquedaProvider(query).future);
    final producto = productos.firstWhere((p) => p.id == productoId);
    final lotes = await ref.read(lotesPorProductoProvider(productoId).future);

    if (!mounted) return;

    if (lotes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay stock disponible para este producto')),
      );
      return;
    }

    int cantidad = 1;
    int? loteId = lotes.first.id;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(producto.nombre),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Precio: Bs. ${producto.precioVenta.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              const Text('Lote:'),
              ...lotes.map((lote) => RadioListTile<int>(
                title: Text('Lote: ${lote.numeroLote ?? "N/A"} - Stock: ${lote.cantidadActual}'),
                value: lote.id,
                groupValue: loteId,
                onChanged: (v) => setDialogState(() => loteId = v),
              )),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Cantidad: '),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (cantidad > 1) setDialogState(() => cantidad--);
                    },
                  ),
                  Text('$cantidad', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      final maxStock = lotes.firstWhere((l) => l.id == loteId).cantidadActual;
                      if (cantidad < maxStock) setDialogState(() => cantidad++);
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                ref.read(carritoProvider.notifier).agregarProducto(
                  productoId: productoId,
                  nombreProducto: producto.nombre,
                  presentacion: producto.presentacion,
                  loteId: loteId!,
                  numeroLote: lotes.firstWhere((l) => l.id == loteId).numeroLote,
                  cantidad: cantidad,
                  precioUnitario: producto.precioVenta,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${producto.nombre} agregado al carrito')),
                );
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  void _agregarPrimerProducto() async {
    final query = _busquedaController.text.trim();
    if (query.isEmpty) return;

    final productos = await ref.read(productosBusquedaProvider(query).future);
    if (productos.isNotEmpty) {
      _seleccionarProducto(productos.first.id);
    }
  }

  Widget _buildPanelCarrito() {
    final carrito = ref.watch(carritoProvider);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            children: [
              const Icon(Icons.shopping_cart),
              const SizedBox(width: 8),
              Text(
                'Carrito (${carrito.cantidadItems} items)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              if (carrito.isNotEmpty)
                TextButton(
                  onPressed: _nuevaVenta,
                  child: const Text('Limpiar'),
                ),
            ],
          ),
        ),
        Expanded(
          child: carrito.isEmpty
              ? const Center(
                  child: Text('El carrito está vacío'),
                )
              : ListView.builder(
                  itemCount: carrito.items.length,
                  itemBuilder: (context, index) {
                    final item = carrito.items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Text(item.nombreProducto),
                        subtitle: Text('Lote: ${item.numeroLote ?? "N/A"}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () {
                                ref.read(carritoProvider.notifier).actualizarCantidad(
                                  index,
                                  item.cantidad - 1,
                                );
                              },
                            ),
                            Text('${item.cantidad}'),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {
                                ref.read(carritoProvider.notifier).actualizarCantidad(
                                  index,
                                  item.cantidad + 1,
                                );
                              },
                            ),
                            Text('Bs. ${item.total.toStringAsFixed(2)}'),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                              onPressed: () {
                                ref.read(carritoProvider.notifier).eliminarItem(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal:'),
                  Text('Bs. ${carrito.subtotal.toStringAsFixed(2)}'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('IVA (13%):'),
                  Text('Bs. ${carrito.igv.toStringAsFixed(2)}'),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Bs. ${carrito.total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Método de pago:'),
                  const SizedBox(width: 16),
                  SegmentedButton<MetodoPago>(
                    segments: const [
                      ButtonSegment(value: MetodoPago.efectivo, label: Text('Efectivo')),
                      ButtonSegment(value: MetodoPago.tarjeta, label: Text('Tarjeta')),
                      ButtonSegment(value: MetodoPago.qr, label: Text('QR')),
                    ],
                    selected: {carrito.metodoPago},
                    onSelectionChanged: (selection) {
                      ref.read(carritoProvider.notifier).setMetodoPago(selection.first);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: carrito.isEmpty ? null : _finalizarVenta,
                  icon: const Icon(Icons.check),
                  label: const Text('Finalizar Venta (F4)'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _nuevaVenta() {
    ref.read(carritoProvider.notifier).limpiar();
    _busquedaController.clear();
    setState(() {
      _productoSeleccionadoId = null;
    });
  }

  Future<void> _finalizarVenta() async {
    final authState = ref.read(authProvider);
    if (authState.usuario == null) return;

    final carrito = ref.read(carritoProvider);
    if (carrito.isEmpty) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Venta'),
        content: Text(
          'Total a pagar: Bs. ${carrito.total.toStringAsFixed(2)}\n'
          'Método de pago: ${carrito.metodoPago.name}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final ventaId = await ref.read(carritoProvider.notifier).finalizarVenta(
      authState.usuario!.id!,
    );

    if (ventaId != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Venta #$ventaId completada exitosamente'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Imprimir',
            textColor: Colors.white,
            onPressed: () => _imprimirNotaVenta(ventaId),
          ),
        ),
      );
      _nuevaVenta();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al procesar la venta'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _imprimirNotaVenta(int ventaId) async {
    final opciones = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Imprimir Nota de Venta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Guardar PDF'),
              onTap: () => Navigator.pop(context, 'pdf'),
            ),
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('Impresora Térmica'),
              onTap: () => Navigator.pop(context, 'thermal'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );

    if (opciones == null) return;

    if (opciones == 'pdf') {
      final service = ref.read(notaVentaServiceProvider);
      final path = await service.generarPdf(ventaId);
      
      if (mounted) {
        if (path != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF guardado en: $path')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al generar PDF')),
          );
        }
      }
    } else if (opciones == 'thermal') {
      final state = ref.read(impresoraStateProvider);
      
      if (!state.inicializada) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Impresora no configurada. Configure en Configuración.')),
          );
        }
        return;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enviando a imprimir...')),
        );
      }
    }
  }
}