import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../features/auth/provider/auth_provider.dart';
import '../features/auth/services/auth_service.dart';

class AppDependencies {
  final FlutterSecureStorage secureStorage;
  final AuthService authService;
  final AuthNotifier authNotifier;

  AppDependencies()
      : secureStorage = const FlutterSecureStorage(),
        authService = AuthService(),
        authNotifier = AuthNotifier(authService: AuthService());
}

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
      'AppDependencies must be provided via ProviderScope.overrideWithValue.');
});


// final appDependenciesProvider = Provider<AppDependencies>((ref) {
//   return AppDependencies();
// });