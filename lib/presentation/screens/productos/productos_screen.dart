import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../providers/producto_provider.dart';
import '../../providers/database_provider.dart';
import '../../../data/datasources/database.dart';

class ProductosScreen extends ConsumerStatefulWidget {
  const ProductosScreen({super.key});

  @override
  ConsumerState<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends ConsumerState<ProductosScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _busquedaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Productos', icon: Icon(Icons.inventory_2)),
            Tab(text: 'Categorías', icon: Icon(Icons.category)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabProductos(),
          _buildTabCategorias(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index == 0) {
            _showDialogProducto(context);
          } else {
            _showDialogCategoria(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTabProductos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _busquedaController,
            decoration: InputDecoration(
              hintText: 'Buscar productos...',
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
            onChanged: (_) => setState(() {}),
          ),
        ),
        Expanded(
          child: _busquedaController.text.isEmpty
              ? ref.watch(productoNotifierProvider).when(
                    data: (productos) => _buildListaProductos(productos),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Error: $e')),
                  )
              : ref.watch(productosBusquedaProvider(_busquedaController.text)).when(
                    data: (productos) => _buildListaProductos(productos),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Error: $e')),
                  ),
        ),
      ],
    );
  }

  Widget _buildListaProductos(List<Producto> productos) {
    if (productos.isEmpty) {
      return const Center(
        child: Text('No hay productos. Agregue uno nuevo.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: productos.length,
      itemBuilder: (context, index) {
        final producto = productos[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(producto.nombre.substring(0, 1).toUpperCase()),
            ),
            title: Text(producto.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (producto.principioActivo != null && producto.principioActivo!.isNotEmpty)
                  Text('Principio: ${producto.principioActivo}'),
                if (producto.codigoBarras != null && producto.codigoBarras!.isNotEmpty)
                  Text('Código: ${producto.codigoBarras}'),
              ],
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
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showDialogProducto(context, producto: producto);
                    } else if (value == 'delete') {
                      _confirmDeleteProducto(context, producto);
                    } else if (value == 'lote') {
                      _showDialogLote(context, producto);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Editar')),
                    const PopupMenuItem(value: 'lote', child: Text('Agregar Lote')),
                    const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                  ],
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  Widget _buildTabCategorias() {
    final categorias = ref.watch(categoriaNotifierProvider);

    return categorias.when(
      data: (cats) {
        if (cats.isEmpty) {
          return const Center(
            child: Text('No hay categorías. Agregue una nueva.'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: cats.length,
          itemBuilder: (context, index) {
            final categoria = cats[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.folder),
                title: Text(categoria.nombre),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _confirmDeleteCategoria(context, categoria),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Future<void> _showDialogProducto(BuildContext context, {Producto? producto}) async {
    final isEdit = producto != null;
    final nombreController = TextEditingController(text: producto?.nombre ?? '');
    final principioController = TextEditingController(text: producto?.principioActivo ?? '');
    final laboratorioController = TextEditingController(text: producto?.laboratorio ?? '');
    final presentacionController = TextEditingController(text: producto?.presentacion ?? '');
    final codigoController = TextEditingController(text: producto?.codigoBarras ?? '');
    final precioController = TextEditingController(text: producto?.precioVenta.toString() ?? '');
    final stockMinimoController = TextEditingController(text: producto?.stockMinimo.toString() ?? '0');
    bool requiereReceta = producto?.requiereReceta ?? false;
    int? categoriaId = producto?.categoriaId;

    final categoriasState = ref.read(categoriaNotifierProvider);
    final List<Categoria> categorias = categoriasState.valueOrNull ?? [];

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEdit ? 'Editar Producto' : 'Nuevo Producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre *'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: principioController,
                  decoration: const InputDecoration(labelText: 'Principio Activo'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: laboratorioController,
                  decoration: const InputDecoration(labelText: 'Laboratorio'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: presentacionController,
                  decoration: const InputDecoration(labelText: 'Presentación'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: codigoController,
                  decoration: const InputDecoration(labelText: 'Código de Barras'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: precioController,
                  decoration: const InputDecoration(labelText: 'Precio Venta *'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: stockMinimoController,
                  decoration: const InputDecoration(labelText: 'Stock Mínimo'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: categoriaId,
                  decoration: const InputDecoration(labelText: 'Categoría'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Sin categoría')),
                    ...categorias.map((c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.nombre),
                        )),
                  ],
                  onChanged: (value) => setDialogState(() => categoriaId = value),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('Requiere Receta'),
                  value: requiereReceta,
                  onChanged: (value) => setDialogState(() => requiereReceta = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                final nombre = nombreController.text.trim();
                final precio = double.tryParse(precioController.text);

                if (nombre.isEmpty || precio == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nombre y precio son requeridos')),
                  );
                  return;
                }

                bool success;
                if (isEdit) {
                  success = await ref.read(productoNotifierProvider.notifier).actualizar(
                        id: producto.id,
                        nombre: nombre,
                        principioActivo: principioController.text.trim().isEmpty ? null : principioController.text.trim(),
                        laboratorio: laboratorioController.text.trim().isEmpty ? null : laboratorioController.text.trim(),
                        presentacion: presentacionController.text.trim().isEmpty ? null : presentacionController.text.trim(),
                        codigoBarras: codigoController.text.trim().isEmpty ? null : codigoController.text.trim(),
                        requiereReceta: requiereReceta,
                        precioVenta: precio,
                        stockMinimo: int.tryParse(stockMinimoController.text) ?? 0,
                        categoriaId: categoriaId,
                      );
                } else {
                  final id = await ref.read(productoNotifierProvider.notifier).crear(
                        nombre: nombre,
                        principioActivo: principioController.text.trim().isEmpty ? null : principioController.text.trim(),
                        laboratorio: laboratorioController.text.trim().isEmpty ? null : laboratorioController.text.trim(),
                        presentacion: presentacionController.text.trim().isEmpty ? null : presentacionController.text.trim(),
                        codigoBarras: codigoController.text.trim().isEmpty ? null : codigoController.text.trim(),
                        requiereReceta: requiereReceta,
                        precioVenta: precio,
                        stockMinimo: int.tryParse(stockMinimoController.text) ?? 0,
                        categoriaId: categoriaId,
                      );
                  success = id != null;
                }

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(success ? 'Guardado' : 'Error al guardar')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteProducto(BuildContext context, Producto producto) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text('¿Eliminar "${producto.nombre}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(productoNotifierProvider.notifier).eliminar(producto.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminado')));
      }
    }
  }

  Future<void> _showDialogCategoria(BuildContext context) async {
    final nombreController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Categoría'),
        content: TextField(
          controller: nombreController,
          decoration: const InputDecoration(labelText: 'Nombre'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final nombre = nombreController.text.trim();
              if (nombre.isEmpty) return;

              await ref.read(categoriaNotifierProvider.notifier).crear(nombre, null);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteCategoria(BuildContext context, Categoria categoria) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text('¿Eliminar "${categoria.nombre}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(categoriaNotifierProvider.notifier).eliminar(categoria.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminado')));
      }
    }
  }

  Future<void> _showDialogLote(BuildContext context, Producto producto) async {
    final numeroLoteController = TextEditingController();
    final cantidadController = TextEditingController();
    final costoController = TextEditingController();
    DateTime? fechaVencimiento;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Agregar Lote - ${producto.nombre}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: numeroLoteController,
                  decoration: const InputDecoration(labelText: 'Número de Lote'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: cantidadController,
                  decoration: const InputDecoration(labelText: 'Cantidad *'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: costoController,
                  decoration: const InputDecoration(labelText: 'Costo Unitario'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: Text(fechaVencimiento == null
                      ? 'Seleccionar fecha de vencimiento'
                      : 'Vence: ${fechaVencimiento!.day}/${fechaVencimiento!.month}/${fechaVencimiento!.year}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 365)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 3650)),
                    );
                    if (picked != null) {
                      setDialogState(() => fechaVencimiento = picked);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                final cantidad = int.tryParse(cantidadController.text);
                if (cantidad == null || cantidad <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ingrese una cantidad válida')),
                  );
                  return;
                }

                final db = ref.read(databaseProvider);
                await db.into(db.lotes).insert(
                  LotesCompanion.insert(
                    productoId: producto.id,
                    numeroLote: Value(numeroLoteController.text.trim().isEmpty ? null : numeroLoteController.text.trim()),
                    fechaVencimiento: Value(fechaVencimiento),
                    cantidadActual: cantidad,
                    costoUnitario: Value(double.tryParse(costoController.text)),
                  ),
                );

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lote agregado')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}