import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario.dart';
import 'database_provider.dart';

class AuthState {
  final Usuario? usuario;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.usuario,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => usuario != null;

  AuthState copyWith({
    Usuario? usuario,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      usuario: usuario ?? this.usuario,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(const AuthState());

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final db = ref.read(databaseProvider);
      final query = db.select(db.usuarios)
        ..where((t) => Expression.and([
          t.username.equals(username),
          t.password.equals(password),
        ]));
      
      final usuario = await query.getSingleOrNull();
      
      if (usuario != null) {
        final rol = usuario.rol == 'administrador' 
            ? RolUsuario.administrador 
            : RolUsuario.cajero;
        
        state = state.copyWith(
          usuario: Usuario(
            id: usuario.id,
            username: usuario.username,
            password: usuario.password,
            rol: rol,
            email: usuario.email,
          ),
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Usuario o contraseña incorrectos',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al iniciar sesión: $e',
      );
      return false;
    }
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});