import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dependencies/app_dependencies.dart';
import '../models/auth_state_model.dart';
import '../services/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService}) : super(const AuthState());

  Future<void> checkLoginStatus() async {
    final isAuthenticated = await authService.isAuthenticated();
    state = state.copyWith(isAuthenticated: isAuthenticated);
  }

  Future<void> login(String username, String password) async {
    final isAuthenticated = await authService.authenticate(username, password);
    state =
        state.copyWith(isAuthenticated: isAuthenticated, userName: username);
  }

  Future<void> logout() async {
    await authService.logoutFromServer();
    state = state.copyWith(isAuthenticated: false, userName: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.authNotifier;
});
