import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/data/data_provider.dart';
import '../features/auth/provider/auth_provider.dart';
import '../features/auth/service/auth_service.dart';
import '../core/services/http_services.dart';
import '../features/service_type/category/provider/category_state.dart';
import '../features/service_type/category/provider/category_provider.dart';

class AppDependencies {
  final FlutterSecureStorage secureStorage;
  final AuthService authService;
  final AuthNotifier authNotifier;
  final HttpService httpService; // Keep HttpService
  final AsyncNotifierProvider<DataNotifier, DataState> dataProviderAsync;

  final StateNotifierProvider<CategoryNotifier, CategoryState> categoryProvider;

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
        dataProviderAsync = AsyncNotifierProvider<DataNotifier, DataState>(
          () => DataNotifier(), // Correct instantiation
        ), // Correct usage of AsyncNotifierProvider
        categoryProvider =
            StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
          final httpService = ref.read(httpServiceProvider); // Correct usage
          return CategoryNotifier(httpService);
        });
}

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
      'AppDependencies must be provided via ProviderScope.overrideWithValue.');
});

// final appDependenciesProvider = Provider<AppDependencies>((ref) {
//   return AppDependencies();
// });
