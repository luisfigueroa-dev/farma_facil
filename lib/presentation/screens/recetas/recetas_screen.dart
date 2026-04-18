import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/receta_provider.dart';
import '../../providers/pos_provider.dart';
import '../../../data/datasources/database.dart';

class RecetasScreen extends ConsumerStatefulWidget {
  const RecetasScreen({super.key});

  @override
  ConsumerState<RecetasScreen> createState() => _RecetasScreenState();
}

class _RecetasScreenState extends ConsumerState<RecetasScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Médicas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Recetas', icon: Icon(Icons.description)),
            Tab(text: 'Sustitutos', icon: Icon(Icons.swap_horiz)),
            Tab(text: 'Alternativas', icon: Icon(Icons.healing)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabRecetas(),
          _buildTabSustitutos(),
          _buildTabAlternativas(),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: () => _showDialogReceta(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildTabRecetas() {
    final recetas = ref.watch(recetaNotifierProvider);

    return recetas.when(
      data: (lista) {
        if (lista.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No hay recetas registradas'),
                SizedBox(height: 8),
                Text('Presione + para agregar una receta'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lista.length,
          itemBuilder: (context, index) {
            final receta = lista[index];
            return _buildRecetaCard(receta);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildRecetaCard(Receta receta) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final estadoColor = _getEstadoColor(receta.estado);
    final detallesAsync = ref.watch(detallesRecetaProvider(receta.id));

    return Card(
      child: ExpansionTile(
        leading: Icon(Icons.description, color: estadoColor),
        title: Text('Receta #${receta.numero}'),
        subtitle: Text('Paciente: ${receta.paciente}'),
        trailing: Chip(
          label: Text(receta.estado.toUpperCase(), style: const TextStyle(fontSize: 10)),
          backgroundColor: estadoColor.withValues(alpha: 0.2),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Médico: ${receta.medico ?? "N/A"}'),
                Text('Fecha emisión: ${dateFormat.format(receta.fechaEmision)}'),
                Text('Vencimiento: ${dateFormat.format(receta.fechaVencimiento)}'),
                const Divider(),
                const Text('Medicamentos:', style: TextStyle(fontWeight: FontWeight.bold)),
                detallesAsync.when(
                  data: (detalles) => Column(
                    children: detalles.map((d) {
                      final productoAsync = ref.watch(productoByIdProvider(d.productoId));
                      return productoAsync.when(
                        data: (producto) => ListTile(
                          dense: true,
                          title: Text(producto?.nombre ?? 'Producto #${d.productoId}'),
                          subtitle: Text('Autorizado: ${d.cantidadAutorizada} - Dispensado: ${d.cantidadDispensada}'),
                        ),
                        loading: () => const ListTile(title: Text('Cargando...')),
                        error: (_, __) => const ListTile(title: Text('Error')),
                      );
                    }).toList(),
                  ),
                  loading: () => const Text('Cargando detalles...'),
                  error: (_, __) => const Text('Error al cargar'),
                ),
                if (receta.estado == 'pendiente')
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showDialogDispensar(context, receta),
                            icon: const Icon(Icons.local_pharmacy),
                            label: const Text('Dispensar'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(context, receta),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'pendiente':
        return Colors.orange;
      case 'dispensada':
        return Colors.green;
      case 'vencida':
        return Colors.red;
      case 'cancelada':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTabSustitutos() {
    final principioController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: principioController,
            decoration: InputDecoration(
              labelText: 'Principio activo',
              hintText: 'Ingrese el principio activo a buscar',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() {}),
              ),
            ),
            onSubmitted: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: principioController.text.isEmpty
                ? const Center(child: Text('Ingrese un principio activo para buscar'))
                : ref.watch(productosSustitutosProvider(principioController.text)).when(
                      data: (productos) {
                        if (productos.isEmpty) {
                          return const Center(child: Text('No se encontraron productos'));
                        }
                        return ListView.builder(
                          itemCount: productos.length,
                          itemBuilder: (context, index) {
                            final p = productos[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.medication),
                                title: Text(p.nombre),
                                subtitle: Text('Laboratorio: ${p.laboratorio ?? "N/A"}'),
                                trailing: Text('Bs. ${p.precioVenta.toStringAsFixed(2)}'),
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Error: $e')),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabAlternativas() {
    final sintomas = ref.watch(sintomasProvider);

    return sintomas.when(
      data: (lista) {
        if (lista.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.healing, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No hay síntomas registrados'),
                SizedBox(height: 8),
                Text('Agregue síntomas en la sección de Productos'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lista.length,
          itemBuilder: (context, index) {
            final sintoma = lista[index];
            final productosAsync = ref.watch(productosPorSintomaProvider(sintoma.id));

            return Card(
              child: ExpansionTile(
                leading: const Icon(Icons.healing),
                title: Text(sintoma.nombre),
                trailing: productosAsync.maybeWhen(
                  data: (productos) => Chip(label: Text('${productos.length}')),
                  orElse: () => const SizedBox(),
                ),
                children: [
                  productosAsync.when(
                    data: (productos) {
                      if (productos.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No hay productos para este síntoma'),
                        );
                      }
                      return Column(
                        children: productos.map((p) => ListTile(
                              title: Text(p.nombre),
                              subtitle: Text(p.principioActivo ?? ''),
                              trailing: Text('Bs. ${p.precioVenta.toStringAsFixed(2)}'),
                            )).toList(),
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                    error: (e, _) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Error: $e'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Future<void> _showDialogReceta(BuildContext context) async {
    final numeroController = TextEditingController();
    final pacienteController = TextEditingController();
    final medicoController = TextEditingController();
    DateTime fechaEmision = DateTime.now();
    DateTime fechaVencimiento = DateTime.now().add(const Duration(days: 30));
    final List<Map<String, dynamic>> detalles = [];
    String? productoSeleccionadoId;
    final cantidadController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Nueva Receta'),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(controller: numeroController, decoration: const InputDecoration(labelText: 'Número de Receta *')),
                  const SizedBox(height: 12),
                  TextField(controller: pacienteController, decoration: const InputDecoration(labelText: 'Paciente *')),
                  const SizedBox(height: 12),
                  TextField(controller: medicoController, decoration: const InputDecoration(labelText: 'Médico')),
                  const SizedBox(height: 12),
                  ListTile(
                    title: Text('Fecha emisión: ${DateFormat('dd/MM/yyyy').format(fechaEmision)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: fechaEmision,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) setDialogState(() => fechaEmision = picked);
                    },
                  ),
                  ListTile(
                    title: Text('Vencimiento: ${DateFormat('dd/MM/yyyy').format(fechaVencimiento)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: fechaVencimiento,
                        firstDate: fechaEmision,
                        lastDate: DateTime.now().add(const Duration(days: 730)),
                      );
                      if (picked != null) setDialogState(() => fechaVencimiento = picked);
                    },
                  ),
                  const Divider(),
                  const Text('Medicamentos:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildSelectorMedicamentos(setDialogState, productoSeleccionadoId, cantidadController, detalles),
                  const SizedBox(height: 8),
                  ...detalles.map((d) => ListTile(
                    dense: true,
                    title: Text(d['nombre']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('x${d['cantidad']}'),
                        IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          onPressed: () {
                            detalles.remove(d);
                            setDialogState(() {});
                          },
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () async {
                if (numeroController.text.isEmpty || pacienteController.text.isEmpty || detalles.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Complete los campos requeridos')),
                  );
                  return;
                }
                final id = await ref.read(recetaNotifierProvider.notifier).crear(
                  numero: numeroController.text,
                  paciente: pacienteController.text,
                  medico: medicoController.text.isEmpty ? null : medicoController.text,
                  fechaEmision: fechaEmision,
                  fechaVencimiento: fechaVencimiento,
                  detalles: detalles,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(id != null ? 'Receta creada' : 'Error')),
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

  Future<void> _showDialogDispensar(BuildContext context, Receta receta) async {
    final detalles = await ref.read(detallesRecetaProvider(receta.id).future);
    final dispensaciones = <int, int>{};

    for (final detalle in detalles) {
      final restante = detalle.cantidadAutorizada - detalle.cantidadDispensada;
      if (restante > 0) {
        dispensaciones[detalle.id] = 0;
      }
    }

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Dispensar Receta #${receta.numero}'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: detalles.where((d) => d.cantidadAutorizada > d.cantidadDispensada).map((detalle) {
                final productoAsync = ref.watch(productoByIdProvider(detalle.productoId));
                final restante = detalle.cantidadAutorizada - detalle.cantidadDispensada;
                return productoAsync.when(
                  data: (producto) => ListTile(
                    title: Text(producto?.nombre ?? 'Producto'),
                    subtitle: Text('Restante: $restante'),
                    trailing: SizedBox(
                      width: 60,
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Cant'),
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          final cant = int.tryParse(v) ?? 0;
                          dispensaciones[detalle.id] = cant > restante ? restante : cant;
                        },
                      ),
                    ),
                  ),
                  loading: () => const ListTile(title: Text('Cargando...')),
                  error: (_, __) => const ListTile(title: Text('Error')),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () async {
                final result = await ref.read(recetaNotifierProvider.notifier).dispensar(
                  receta.id,
                  dispensaciones,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result ? 'Dispensado' : 'Error')),
                  );
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Receta receta) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text('¿Eliminar receta #${receta.numero}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(recetaNotifierProvider.notifier).eliminar(receta.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Eliminado')));
      }
    }
  }

  Widget _buildSelectorMedicamentos(
    void Function(void Function()) setDialogState,
    String? productoSeleccionadoId,
    TextEditingController cantidadController,
    List<Map<String, dynamic>> detalles,
  ) {
    final productosAsync = ref.watch(productosBusquedaProvider(''));
    
    return productosAsync.when(
      data: (productos) => Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: productoSeleccionadoId,
              decoration: const InputDecoration(labelText: 'Producto'),
              items: productos.where((p) => p.requiereReceta).map((p) => DropdownMenuItem(
                value: p.id.toString(),
                child: Text(p.nombre, overflow: TextOverflow.ellipsis),
              )).toList(),
              onChanged: (v) => setDialogState(() => productoSeleccionadoId = v),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: TextField(
              controller: cantidadController,
              decoration: const InputDecoration(labelText: 'Cant'),
              keyboardType: TextInputType.number,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (productoSeleccionadoId != null && cantidadController.text.isNotEmpty) {
                final producto = productos.firstWhere((p) => p.id.toString() == productoSeleccionadoId);
                detalles.add({
                  'productoId': int.parse(productoSeleccionadoId!),
                  'nombre': producto.nombre,
                  'cantidad': int.tryParse(cantidadController.text) ?? 0,
                });
                cantidadController.clear();
                setDialogState(() {});
              }
            },
          ),
        ],
      ),
      loading: () => const LinearProgressIndicator(),
      error: (_, __) => const Text('Error al cargar productos'),
    );
  }
}