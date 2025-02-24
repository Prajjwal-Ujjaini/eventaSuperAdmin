import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data/data_provider.dart';
import '../../../core/services/http_services.dart';
import '../../../core/utility/notification_helper.dart';
import '../../../models/api_response.dart';
import '../model/service_type_model.dart';
import '../model/service_type_state_model.dart';

class ServiceTypeNotifier extends StateNotifier<ServiceTypeStateModel> {
  final HttpService service;
  final DataNotifier dataNotifier; // Add DataNotifier as a parameter

  ServiceTypeNotifier(this.service, this.dataNotifier)
      : super(ServiceTypeStateModel.initial());

  Future<void> addServiceType() async {
    log('*addServiceType called*');

    try {
      if (state.selectedImage == null) {
        NotificationHelper.showErrorNotification('Please Choose An Image!');
        return;
      }

      Map<String, dynamic> formData = {
        'serviceTypeName': state.serviceTypeNameCtrl.text,
        'serviceTypeDescription': 'no_data',
      };

      // final data =
      //     await createFormData(imgXFile: state.imgXFile, formData: formData);

      final response =
          await service.addItem(endpointUrl: 'serviceType', itemData: formData);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        log('addServiceType responseBody =: ${responseBody} ');

        ApiResponse apiResponse = ApiResponse.fromJson(responseBody, null);
        if (apiResponse.success == true) {
          clearFields();
          // Call fetch serviceTypes _dataProvider.getAllServiceType();
          log('!!!!! addServiceType calling ref.read(dataProviderAsync.notifier).getAllServiceType(); !!!!!!!!!');
          // if (ref.context.mounted) {
          await dataNotifier.getAllServiceType();
          // }
          log('serviceType added');

          NotificationHelper.showSuccessNotification('${apiResponse.message}');
        } else {
          NotificationHelper.showErrorNotification(
              'Failed to add serviceType: ${apiResponse.message}');
        }
      } else {
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
            'Error: ${errorBody['message'] ?? response.statusCode}');
      }
    } catch (e) {
      print(e);
      NotificationHelper.showErrorNotification('An Error occured: $e');
      rethrow;
    }
  }

  Future<void> updateServiceType() async {
    log('*updateServiceType called*');
    try {
      Map<String, dynamic> formData = {
        'serviceTypeName': state.serviceTypeNameCtrl.text,
        'serviceTypeDescription': 'no_data',
        'image': state.serviceTypeForUpdate?.serviceTypeDescription ?? '',
      };

      // final data =
      //     await createFormData(imgXFile: state.imgXFile, formData: formData);
      final response = await service.updateItem(
          endpointUrl: 'serviceType',
          itemData: formData,
          itemId: state.serviceTypeForUpdate?.serviceTypeId ?? '');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        log('updateServiceType responseBody =: ${responseBody} ');
        ApiResponse apiResponse = ApiResponse.fromJson(responseBody, null);
        if (apiResponse.success == true) {
          clearFields();
          NotificationHelper.showSuccessNotification('${apiResponse.message}');
          // Call fetch serviceTypes  _dataProvider.getAllServiceType();
          await dataNotifier.getAllServiceType();

          log('serviceType Updated');
        } else {
          NotificationHelper.showErrorNotification(
              'Failed to update serviceType: ${apiResponse.message}');
        }
      } else {
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
            'Error: ${errorBody['message'] ?? response.statusCode}');
      }
    } catch (e) {
      print(e);
      NotificationHelper.showErrorNotification('An Error occured: $e');
      rethrow;
    }
  }

  submitServiceType() {
    log('submitServiceType called serviceTypeId != null  =: ${state.serviceTypeForUpdate?.serviceTypeId?.isNotEmpty == true} ');

    // Check if the serviceTypeForUpdate has a valid serviceTypeId
    if (state.serviceTypeForUpdate != null &&
        state.serviceTypeForUpdate!.serviceTypeId?.isNotEmpty == true) {
      updateServiceType(); // Update if serviceTypeId is present
    } else {
      addServiceType(); // Add a new service type if no valid ID
    }
  }

  Future<void> deleteServiceType(ServiceTypeModel serviceTypeModel) async {
    try {
      final response = await service.deleteItem(
          endpointUrl: 'serviceType',
          itemId: serviceTypeModel.serviceTypeId ?? '');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        log('deleteServiceType responseBody =: ${responseBody} ');
        ApiResponse apiResponse = ApiResponse.fromJson(responseBody, null);
        if (apiResponse.success == true) {
          // Call fetch serviceTypes _dataProvider.getAllServiceType();
          await dataNotifier.getAllServiceType();

          NotificationHelper.showSuccessNotification(
              'ServiceTypeModel Deleted Successfully');
        }
      } else {
        final errorBody = jsonDecode(response.body);
        NotificationHelper.showErrorNotification(
            'Error: ${errorBody['message'] ?? response.statusCode}');
      }
    } catch (e) {
      print(e);
      NotificationHelper.showErrorNotification('An Error occured: $e');
      rethrow;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(selectedImage: File(image.path), imgXFile: image);
    }
  }

  // Future<FormData> createFormData(
  //     {required XFile? imgXFile,
  //     required Map<String, dynamic> formData}) async {
  //   if (imgXFile != null) {
  //     String fileName = imgXFile.path.split('/').last;
  //     formData['img'] = MultipartFile(imgXFile.path, filename: fileName);
  //   }
  //   final FormData form = FormData(formData);
  //   return form;
  // }

  //? set data for update on editing
  void setDataForUpdateServiceType(ServiceTypeModel? serviceTypeModel) {
    log('setDataForUpdateServiceType serviceType =: ${serviceTypeModel.toString()} ');

    // Clear existing fields before setting new data
    clearFields();

    // Check the state after clearing fields to ensure it was applied correctly
    log('After clearing fields in setDataForUpdateServiceType, state =: ${state.toString()}');

    if (serviceTypeModel != null) {
      log('In IF  serviceTypeModel != null  =: ${serviceTypeModel != null} ');

      // Manually reset the controller to ensure it's fresh
      final newController =
          TextEditingController(text: serviceTypeModel.serviceTypeName ?? '');

      // Apply the new state after clearing
      state = state.copyWith(
        serviceTypeForUpdate: serviceTypeModel,
        serviceTypeNameCtrl: newController,
      );

      log('State after setting serviceTypeForUpdate in setDataForUpdateServiceType, state =: ${state.toString()}');
    } else {
      log('In Else  serviceTypeModel != null  =: ${serviceTypeModel != null} ');
      // The state should already be cleared by clearFields
    }
  }

  void clearFields() {
    log('clearFields called  state =: ${state.toString()} ');

    // Clear the fields and reset the state
    state.serviceTypeNameCtrl.clear(); // Explicitly clear the controller
    state = state.copyWith(
      serviceTypeNameCtrl: TextEditingController(),
      selectedImage: null,
      imgXFile: null,
      serviceTypeForUpdate: ServiceTypeModel(),
    );

    // Force an async delay to ensure the state is fully updated
    Future.microtask(() {
      log('After clearFields (microtask) state =: ${state.toString()} ');
    });

    log('After clearFields called  state =: ${state.toString()} ');
  }
}

final serviceTypeProvider =
    StateNotifierProvider<ServiceTypeNotifier, ServiceTypeStateModel>((ref) {
  final httpService = ref.read(httpServiceProvider);
  final dataNotifier = ref.read(dataProviderAsync.notifier); // Get DataNotifier

  return ServiceTypeNotifier(
      httpService, dataNotifier); // Pass DataNotifier to the constructor
});
