import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../../models/api_response.dart';
import '../../features/service_type/model/service_type_model.dart';
import '../services/http_services.dart';
import '../utility/notification_helper.dart';

class DataState {
  final List<ServiceTypeModel> allServiceType;
  final List<ServiceTypeModel> filteredServiceType;

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
    List<ServiceTypeModel>? allServiceType,
    List<ServiceTypeModel>? filteredServiceType,
  }) {
    return DataState(
      allServiceType: allServiceType ?? this.allServiceType,
      filteredServiceType: filteredServiceType ?? this.filteredServiceType,
    );
  }
}

class DataNotifier extends StateNotifier<DataState> {
  final HttpService service;

  DataNotifier(this.service) : super(DataState.initial()) {
    getAllServiceType();
  }

  Future<void> getAllServiceType({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'serviceType');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var jsonResponse = jsonDecode(response.body);

        ApiResponse<List<ServiceTypeModel>> apiResponse =
            ApiResponse<List<ServiceTypeModel>>.fromJson(
                jsonResponse,
                (json) => (json as List)
                    .map((item) => ServiceTypeModel.fromJson(item))
                    .toList());

        state = state.copyWith(
          allServiceType: apiResponse.data ?? [],
          filteredServiceType: apiResponse.data ?? [],
        );

        if (showSnack) {
          NotificationHelper.showSuccessNotification(apiResponse.message);
        }
      }
    } catch (e) {
      print(e);
      if (showSnack) NotificationHelper.showErrorNotification(e.toString());
      rethrow;
    }
  }

  void filterServiceType(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    final filtered = state.allServiceType.where((serviceType) {
      return (serviceType.serviceTypeName ?? '')
          .toLowerCase()
          .contains(lowerKeyword);
    }).toList();

    state = state.copyWith(filteredServiceType: filtered);
  }
}

// Create a StateNotifierProvider for DataNotifier
final dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return DataNotifier(httpService);
});
