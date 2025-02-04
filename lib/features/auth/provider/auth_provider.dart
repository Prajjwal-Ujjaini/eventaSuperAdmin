import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dependencies/app_dependencies.dart';
import '../models/auth_state_model.dart';
import '../services/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService}) : super(const AuthState()) {
    _checkLoginStatus();
  }

  // Check login status on startup
  Future<void> _checkLoginStatus() async {
    final isAuthenticated = await authService.isAuthenticated();
    if (isAuthenticated) {
      // If the token exists, consider the user authenticated
      state = state.copyWith(
          isAuthenticated: true,
          userName: 'John Doe'); // Update with actual user data
    }
  }

  // Login method
  Future<bool> login(String username, String password) async {
    final isAuthenticated = await authService.authenticate(username, password);

    if (isAuthenticated) {
      state = AuthState(isAuthenticated: true);
      return true; // Return true when authentication is successful
    } else {
      state = AuthState(isAuthenticated: false);
      return false; // Return false when authentication fails
    }
  }

  // Signup method
  Future<bool> signup(String username, String password) async {
    final isSignedUp = await authService.register(username, password);

    if (isSignedUp) {
      state = AuthState(isAuthenticated: true);
      return true; // Return true when registration is successful
    } else {
      return false; // Return false when registration fails
    }
  }

  // Forgot password method
  Future<bool> forgotPassword(String email) async {
    final isPasswordReset = await authService.resetPassword(email);

    if (isPasswordReset) {
      // Maybe you want to show a confirmation message to the user
      return true;
    } else {
      // Handle the case where resetting the password fails
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    await authService.logoutFromServer();
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.authNotifier;
});
