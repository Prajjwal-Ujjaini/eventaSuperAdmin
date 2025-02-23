import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../../features/service_type/category/category.dart';
import '../../models/api_response.dart';
import '../services/http_services.dart';
import '../utility/notification_helper.dart';

class DataState {
  final List<Category> allServiceType;
  final List<Category> filteredServiceType;

  DataState({
    required this.allServiceType,
    required this.filteredServiceType,
  });

  // Initial empty state
  factory DataState.initial() {
    return DataState(
      allServiceType: [],
      filteredServiceType: [],
    );
  }

  // Create a new copy of the state with updated values (immutability)
  DataState copyWith({
    List<Category>? allServiceType,
    List<Category>? filteredServiceType,
  }) {
    return DataState(
      allServiceType: allServiceType ?? this.allServiceType,
      filteredServiceType: filteredServiceType ?? this.filteredServiceType,
    );
  }
}

class DataNotifier extends AsyncNotifier<DataState> {
  late HttpService service;

  @override
  Future<DataState> build() async {
    service = ref.read(httpServiceProvider);
    log('************* DataNotifier inside build getAllServiceType called *************');

    // Initialize with the initial state
    state = const AsyncValue.loading();

    await getAllServiceType(); // This no longer returns DataState directly

    // Return the current state value (which was updated in getAllServiceType)
    return state.value ?? DataState.initial();
  }

  Future<void> getAllServiceType({bool showSnack = false}) async {
    state = const AsyncValue.loading(); // Set loading state
    log('****getAllServiceType called ****');
    try {
      Response response = await service.getItems(endpointUrl: 'categories');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonResponse = jsonDecode(response.body);

        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
                jsonResponse,
                (json) => (json as List)
                    .map((item) => Category.fromJson(item))
                    .toList());
        log('apiResponse.data :${apiResponse.data}');
        log('apiResponse.data.length :${apiResponse.data!.length}');

        if (showSnack) {
          NotificationHelper.showSuccessNotification(apiResponse.message);
        }

        // Update the state here
        state = AsyncValue.data(DataState(
          allServiceType: apiResponse.data ?? [],
          filteredServiceType: apiResponse.data ?? [],
        ));
      } else {
        throw Exception('Failed to load service types');
      }
    } catch (e) {
      // Update the state to error state
      state = AsyncValue.error(e, StackTrace.current);
      print(e);
      if (showSnack) NotificationHelper.showErrorNotification(e.toString());
      // throw e;
    }
  }

  void filterServiceType(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    final filtered = state.value!.allServiceType.where((serviceType) {
      return (serviceType.name ?? '').toLowerCase().contains(lowerKeyword);
    }).toList();

    state = AsyncValue.data(
      state.value!.copyWith(filteredServiceType: filtered),
    );
  }
}

/// The `dataProviderAsync` is an `AsyncNotifierProvider` for managing async state.
final dataProviderAsync =
    AsyncNotifierProvider<DataNotifier, DataState>(() => DataNotifier());

/// The `dataProvider` is a StateNotifierProvider for managing and watching the state of the service types.
///
/// It allows you to interact with the `DataNotifier` methods and retrieve the service type data.
///
/// How to use:
///
/// 1. To fetch service types and show notifications based on success or failure:
/// ```
/// ref.read(dataProvider.notifier).getAllServiceType(showSnack: true); // Fetch with notification.
/// ref.read(dataProvider.notifier).getAllServiceType(showSnack: false); // Fetch without notification.
/// ```
///
/// 2. To filter the service types:
/// ```
/// ref.read(dataProvider.notifier).filterServiceType('keyword'); // Filters the service types by keyword.
/// ```
///
/// 3. To watch the filtered service types:
/// ```
/// final serviceTypes = ref.watch(dataProvider).filteredServiceType; // Watch the filtered service types.
/// ```
// final dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
//   final httpService = ref.watch(httpServiceProvider);
//   return DataNotifier(httpService);
// });
