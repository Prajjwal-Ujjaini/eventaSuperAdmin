import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/data/data_provider.dart';
import '../features/auth/provider/auth_provider.dart';
import '../features/auth/service/auth_service.dart';
import '../core/services/http_services.dart';

class AppDependencies {
  final FlutterSecureStorage secureStorage;
  final AuthService authService;
  final AuthNotifier authNotifier;
  final HttpService httpService; // Keep HttpService
  final StateNotifierProvider<DataNotifier, DataState>
      dataProvider; // Use StateNotifierProvider

  AppDependencies(ProviderContainer container)
      : secureStorage = const FlutterSecureStorage(),
        httpService = HttpService(),
        authService = AuthService(
          secureStorage: const FlutterSecureStorage(),
          httpService: HttpService(),
        ),
        authNotifier = AuthNotifier(
          authService: AuthService(
            secureStorage: const FlutterSecureStorage(),
            httpService: HttpService(),
          ),
        ),
        dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
          final httpService = ref.watch(httpServiceProvider);
          return DataNotifier(httpService);
        });
}

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
      'AppDependencies must be provided via ProviderScope.overrideWithValue.');
});


// final appDependenciesProvider = Provider<AppDependencies>((ref) {
//   return AppDependencies();
// });