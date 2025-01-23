import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> authenticate(String username, String password) async {
    // Simulate API call to authenticate user
    await Future.delayed(Duration(seconds: 1));

    if (username == "admin" && password == "password") {
      // Store authenticated state in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      return true;
    }
    return false;
  }

  Future<void> logoutFromServer() async {
    // Simulate logout call
    await Future.delayed(Duration(seconds: 1));

    // Clear authenticated state
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuthenticated');
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false;
  }
}
