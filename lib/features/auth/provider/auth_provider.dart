import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dependencies/app_dependencies.dart';
import '../model/auth_state_model.dart';
import '../model/user_model.dart';
import '../service/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService})
      : super(AuthState(isAuthenticated: false, isLoading: true)) {
    _checkLoginStatus(); // Automatically check login status when AuthNotifier is created
  }

  // Check login status on startup
  Future<void> _checkLoginStatus() async {
    log('_checkLoginStatus ');
    try {
      final isAuthenticated = await authService.isAuthenticated();
      log('_checkLoginStatus isAuthenticated    =: ${isAuthenticated} ');

      if (isAuthenticated) {
        UserModel? user = await authService.getStoredUser();
        log('_checkLoginStatus if user    =: ${user} ');

        state =
            state.copyWith(isAuthenticated: true, user: user, isLoading: false);
      } else {
        log('_checkLoginStatus else  ');

        state = state.copyWith(
          isAuthenticated: false,
          isLoading: false,
        );
        log('_checkLoginStatus else  state : ${state}');
      }
    } catch (e) {
      // Handle error
      state = state.copyWith(isLoading: false);
      log('_checkLoginStatus catch  state : ${state}');
    }
  }

  // Login method
  Future<bool> login(String username, String password) async {
    log('login');

    // Set loading to true while trying to authenticate
    state = state.copyWith(isLoading: true);

    final isAuthenticated = await authService.authenticate(username, password);

    if (isAuthenticated) {
      UserModel? user = await authService.getStoredUser();
      // Update state with isAuthenticated, user, and set loading to false
      state = AuthState(isAuthenticated: true, user: user, isLoading: false);
      return true;
    } else {
      // Update state with isAuthenticated = false and loading to false
      state = AuthState(isAuthenticated: false, isLoading: false);
      return false;
    }
  }

// Signup method
  Future<bool> signup(String username, String password) async {
    // Set loading to true while trying to register
    state = state.copyWith(isLoading: true);

    final isSignedUp = await authService.register(username, password);
    log('signup isSignedUp    =: ${isSignedUp} ');

    if (isSignedUp) {
      UserModel? user = await authService.getStoredUser();
      log('signup user.toString()    =: ${user.toString()} ');

      // Update state with isAuthenticated, user, and set loading to false
      state = AuthState(isAuthenticated: true, user: user, isLoading: false);
      return true;
    } else {
      // Update state with isAuthenticated = false and loading to false
      state = AuthState(isAuthenticated: false, isLoading: false);
      return false;
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
    log('logout');

    // Set loading to true while logging out
    state = state.copyWith(isLoading: true);

    await authService.logoutFromServer();

    // Reset state after logout and set loading to false
    state = AuthState(isAuthenticated: false, user: null, isLoading: false);
    log('logout state ${state.toString()}');
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.authNotifier;
});
final authCheckProvider = FutureProvider<bool>((ref) async {
  final appDependencies = ref.watch(appDependenciesProvider);
  return appDependencies.authService.isAuthenticated();
});
