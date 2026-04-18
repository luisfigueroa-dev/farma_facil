import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart' show Value;
import '../../providers/database_provider.dart';
import '../../providers/impresora_provider.dart';
import '../../../data/datasources/database.dart';

class ConfiguracionScreen extends ConsumerStatefulWidget {
  const ConfiguracionScreen({super.key});

  @override
  ConsumerState<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends ConsumerState<ConfiguracionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _nitController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _rutaPdfController = TextEditingController();
  String? _selectedPuerto;
  bool _isLoading = true;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _loadConfiguracion();
  }

  Future<void> _loadConfiguracion() async {
    final db = ref.read(databaseProvider);
    final configs = await db.select(db.configuraciones).get();

    for (final config in configs) {
      switch (config.clave) {
        case 'nombre_farmacia':
          _nombreController.text = config.valor;
          break;
        case 'direccion':
          _direccionController.text = config.valor;
          break;
        case 'nit':
          _nitController.text = config.valor;
          break;
        case 'telefono':
          _telefonoController.text = config.valor;
          break;
        case 'ruta_pdf':
          _rutaPdfController.text = config.valor;
          break;
      }
    }

    if (_rutaPdfController.text.isEmpty) {
      final docsDir = await getApplicationDocumentsDirectory();
      _rutaPdfController.text = p.join(docsDir.path, 'FarmaFacil');
    }

    final printerState = ref.read(impresoraStateProvider);
    _selectedPuerto = printerState.puerto;

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _guardarConfiguracion() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);

    await db.transaction(() async {
      await _updateConfig(db, 'nombre_farmacia', _nombreController.text);
      await _updateConfig(db, 'direccion', _direccionController.text);
      await _updateConfig(db, 'nit', _nitController.text);
      await _updateConfig(db, 'telefono', _telefonoController.text);
      await _updateConfig(db, 'ruta_pdf', _rutaPdfController.text);
    });

    setState(() {
      _hasChanges = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuración guardada')),
      );
    }
  }

  Future<void> _updateConfig(AppDatabase db, String clave, String valor) async {
    await (db.update(db.configuraciones)..where((t) => t.clave.equals(clave)))
        .write(ConfiguracionesCompanion(valor: Value(valor)));
  }

  Future<void> _testImpresora() async {
    if (_selectedPuerto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Seleccione un puerto')),
      );
      return;
    }

    final result = await ref.read(impresoraStateProvider.notifier).inicializar(_selectedPuerto!);

    if (mounted) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impresora conectada en $_selectedPuerto')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al conectar')),
        );
      }
    }
  }

  Future<void> _selectRuta() async {
    final docsDir = await getApplicationDocumentsDirectory();
    setState(() {
      _rutaPdfController.text = p.join(docsDir.path, 'FarmaFacil');
      _hasChanges = true;
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    _nitController.dispose();
    _telefonoController.dispose();
    _rutaPdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final printerState = ref.watch(impresoraStateProvider);

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        actions: [
          if (_hasChanges)
            TextButton.icon(
              onPressed: _guardarConfiguracion,
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Datos de la Farmacia'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de la Farmacia',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() => _hasChanges = true),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _direccionController,
                      decoration: const InputDecoration(
                        labelText: 'Dirección',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() => _hasChanges = true),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nitController,
                      decoration: const InputDecoration(
                        labelText: 'NIT',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() => _hasChanges = true),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _telefonoController,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() => _hasChanges = true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Guardado de PDF'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _rutaPdfController,
                      decoration: InputDecoration(
                        labelText: 'Carpeta para Notas de Venta PDF',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.folder_open),
                          onPressed: _selectRuta,
                        ),
                      ),
                      onChanged: (_) => setState(() => _hasChanges = true),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Los archivos PDF se guardarán en esta carpeta',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Impresora Térmica'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          printerState.inicializada ? Icons.check_circle : Icons.error,
                          color: printerState.inicializada ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          printerState.inicializada
                              ? 'Conectada en ${printerState.puerto}'
                              : 'No configurada',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedPuerto,
                      decoration: const InputDecoration(
                        labelText: 'Puerto COM',
                        border: OutlineInputBorder(),
                      ),
                      items: ref.read(impresoraStateProvider.notifier)
                          .puertosDisponibles
                          .map((puerto) => DropdownMenuItem(
                                value: puerto,
                                child: Text(puerto),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPuerto = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _testImpresora,
                            icon: const Icon(Icons.settings_input_hdmi),
                            label: const Text('Conectar'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ref.read(impresoraStateProvider.notifier).desconectar();
                            },
                            icon: const Icon(Icons.link_off),
                            label: const Text('Desconectar'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Seleccione el puerto COM correspondiente a su impresora térmica',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Atajos de Teclado'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShortcut('F1', 'Enfocar búsqueda de productos'),
                    _buildShortcut('F4', 'Finalizar venta'),
                    _buildShortcut('F5', 'Nueva venta / Limpiar'),
                    _buildShortcut('Ctrl+N', 'Nueva venta'),
                    _buildShortcut('Ctrl+P', 'Imprimir última nota'),
                    _buildShortcut('Esc', 'Cancelar / Limpiar búsqueda'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Acerca de'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('FarmaFacil v1.0.0'),
                    const SizedBox(height: 8),
                    Text(
                      'Sistema de Ventas para Farmacia',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildShortcut(String key, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              key,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(description),
        ],
      ),
    );
  }
}