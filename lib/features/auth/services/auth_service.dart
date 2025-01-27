import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> authenticate(String username, String password) async {
    // Simulate API call to authenticate user
    await Future.delayed(const Duration(seconds: 1));

    if (username == "admin" && password == "password") {
      await _secureStorage.write(key: 'auth_token', value: 'token_value');
      return true;
    }
    return false;
  }

  Future<void> logoutFromServer() async {
    await Future.delayed(const Duration(seconds: 1));
    await _secureStorage.delete(key: 'auth_token');
  }

  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: 'auth_token');
    return token != null;
  }
}
