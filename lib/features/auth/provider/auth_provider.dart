import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dependencies/app_dependencies.dart';
import '../models/auth_state_model.dart';
import '../services/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService}) : super(const AuthState()) {
    _checkLoginStatus();
  }
  Future<void> _checkLoginStatus() async {
    final isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      // If the token exists, consider the user authenticated
      state = state.copyWith(
          isAuthenticated: true,
          userName: 'John Doe'); // Update with actual user data
    }
  }

  Future<void> login(String username, String password) async {
    final isAuthenticated = await authService.authenticate(username, password);

    if (isAuthenticated) {
      // Update the state as authenticated
      state = state.copyWith(isAuthenticated: true, userName: username);
    }
  }

  Future<void> logout() async {
    await authService.logoutFromServer();
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.authNotifier;
});
