import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;

import '../../models/service_type_model.dart';
import '../../services/http_services.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<ServiceTypeModel> _allServiceType = [];
  List<ServiceTypeModel> _filteredServiceType = [];
  List<ServiceTypeModel> get serviceTypes => _filteredServiceType;

  DataProvider() {
    // getAllServiceType();
  }

  // Future<List<ServiceTypeModel>> getAllServiceType(
  //     {bool showSnack = false}) async {
  //   try {
  //     Response response = await service.getItems(endpointUrl: 'serviceType');

  //     if (response.isOk) {
  //       ApiResponse<List<ServiceTypeModel>> apiResponse =
  //           ApiResponse<List<ServiceTypeModel>>.fromJson(
  //               response.body,
  //               (json) => (json as List)
  //                   .map((item) => ServiceTypeModel.fromJson(item))
  //                   .toList());
  //       _allServiceType = apiResponse.data ?? [];
  //       _filteredServiceType = List.from(_allServiceType);
  //       notifyListeners();
  //       if (showSnack) SnackBarHelper.showSuccessSnackBar(apiResponse.message);
  //     }
  //   } catch (e) {
  //     print(e);
  //     if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
  //     rethrow;
  //   }
  //   return _filteredServiceType;
  // }

  void filterServiceType(String keyword) {
    if (keyword.isEmpty) {
      _filteredServiceType = List.from(_allServiceType);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredServiceType = _allServiceType.where((serviceType) {
        return (serviceType.serviceTypeName ?? '')
            .toLowerCase()
            .contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
}
