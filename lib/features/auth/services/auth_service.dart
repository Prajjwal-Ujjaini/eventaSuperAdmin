import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../services/http_services.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage;
  final HttpService _httpService;

  AuthService({
    required FlutterSecureStorage secureStorage,
    required HttpService httpService,
  })  : _secureStorage = secureStorage,
        _httpService = httpService;

  Future<bool> authenticate(String username, String password) async {
    final response = await _httpService.addItem(
      endpointUrl: 'auth/login', // API endpoint
      itemData: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final token = responseBody['auth_token'];
      await _secureStorage.write(key: 'auth_token', value: token);
      return true;
    }
    return false;
  }

  // Simulate registration (signup)
  Future<bool> register(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simulate successful registration
    if (username.isNotEmpty && password.isNotEmpty) {
      await _secureStorage.write(key: 'auth_token', value: 'token_value');
      return true;
    }
    return false;
  }

  // Simulate password reset (forgot password)
  Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simulate checking for a valid email and sending a reset email
    if (email == "user@example.com") {
      // In a real-world scenario, you would send an email to the user
      return true;
    }
    return false;
  }

  // Logout user
  Future<void> logoutFromServer() async {
    await Future.delayed(const Duration(seconds: 1));
    await _secureStorage.delete(key: 'auth_token');
  }

  // Check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: 'auth_token');
    return token != null;
  }
}
