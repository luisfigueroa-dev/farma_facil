import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_provider.dart';
import '../../core/utils/nota_venta_service.dart';
import '../../core/utils/impresora_termica_service.dart';

final notaVentaServiceProvider = Provider<NotaVentaService>((ref) {
  final db = ref.read(databaseProvider);
  return NotaVentaService(db);
});

final impresoraTermicaProvider = Provider<ImpresoraTermicaService>((ref) {
  return ImpresoraTermicaService();
});

class ImpresoraState {
  final bool inicializada;
  final String? puerto;
  final String? error;

  const ImpresoraState({
    this.inicializada = false,
    this.puerto,
    this.error,
  });

  ImpresoraState copyWith({
    bool? inicializada,
    String? puerto,
    String? error,
  }) {
    return ImpresoraState(
      inicializada: inicializada ?? this.inicializada,
      puerto: puerto ?? this.puerto,
      error: error,
    );
  }
}

class ImpresoraNotifier extends StateNotifier<ImpresoraState> {
  final ImpresoraTermicaService _service;

  ImpresoraNotifier(this._service) : super(const ImpresoraState());

  List<String> get puertosDisponibles => _service.getPuertosDisponibles();

  Future<bool> inicializar(String puerto) async {
    try {
      final resultado = await _service.inicializar(puerto);
      state = state.copyWith(
        inicializada: resultado,
        puerto: resultado ? puerto : null,
        error: resultado ? null : 'Error al inicializar',
      );
      return resultado;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  void desconectar() {
    _service.desconectar();
    state = const ImpresoraState();
  }
}

final impresoraStateProvider = StateNotifierProvider<ImpresoraNotifier, ImpresoraState>((ref) {
  final service = ref.read(impresoraTermicaProvider);
  return ImpresoraNotifier(service);
});