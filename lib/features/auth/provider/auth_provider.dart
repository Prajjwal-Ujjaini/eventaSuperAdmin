import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dependencies/app_dependencies.dart';
import '../services/auth_service.dart';

class AuthNotifier extends StateNotifier<bool> {
  final AuthService authService;

  AuthNotifier({required this.authService}) : super(false) {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isAuthenticated = await authService.isAuthenticated();
    state = isAuthenticated;
  }

  Future<void> login(String username, String password) async {
    final isAuthenticated = await authService.authenticate(username, password);
    state = isAuthenticated;
  }

  Future<void> logout() async {
    await authService.logoutFromServer();
    state = false;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.authNotifier;
});
