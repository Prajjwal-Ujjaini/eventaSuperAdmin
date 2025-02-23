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

  // Private constructor
  AppDependencies._({
    required this.secureStorage,
    required this.authService,
    required this.authNotifier,
    required this.httpService,
    required this.dataProviderAsync,
    required this.categoryProvider,
  });

  // Factory method to create AppDependencies
  factory AppDependencies(ProviderContainer container) {
    final secureStorage = const FlutterSecureStorage();
    final httpService = HttpService();
    final dataProviderAsync = AsyncNotifierProvider<DataNotifier, DataState>(
      () => DataNotifier(),
    );

    final categoryProvider =
        StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
      final httpService = ref.read(httpServiceProvider);
      final dataNotifier = ref.read(dataProviderAsync.notifier);
      return CategoryNotifier(httpService, dataNotifier); // Pass both arguments
    });

    return AppDependencies._(
      secureStorage: secureStorage,
      httpService: httpService,
      authService: AuthService(
        secureStorage: secureStorage,
        httpService: httpService,
      ),
      authNotifier: AuthNotifier(
        authService: AuthService(
          secureStorage: secureStorage,
          httpService: httpService,
        ),
      ),
      dataProviderAsync: dataProviderAsync,
      categoryProvider: categoryProvider,
    );
  }
}

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
      'AppDependencies must be provided via ProviderScope.overrideWithValue.');
});

// final appDependenciesProvider = Provider<AppDependencies>((ref) {
//   return AppDependencies();
// });
