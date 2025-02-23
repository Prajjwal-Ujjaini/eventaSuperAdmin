import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/data_provider.dart';
import '../../../../core/services/http_services.dart';
import '../../../../core/utility/notification_helper.dart';
import '../../../../models/api_response.dart';
import '../category.dart';
import 'category_state.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final HttpService service;
  final DataNotifier dataNotifier; // Add DataNotifier as a parameter

  CategoryNotifier(this.service, this.dataNotifier)
      : super(CategoryState.initial());

  Future<void> addCategory() async {
    log('*addCategory called*');

    try {
      if (state.selectedImage == null) {
        NotificationHelper.showErrorNotification('Please Choose An Image!');
        return;
      }

      Map<String, dynamic> formData = {
        'name': state.categoryNameCtrl.text,
        'image': 'no_data',
      };

      // final data =
      //     await createFormData(imgXFile: state.imgXFile, formData: formData);

      final response =
          await service.addItem(endpointUrl: 'categories', itemData: formData);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        log('addCategory responseBody =: ${responseBody} ');

        ApiResponse apiResponse = ApiResponse.fromJson(responseBody, null);
        if (apiResponse.success == true) {
          clearFields();
          // Call fetch categories _dataProvider.getAllCategory();
          log('!!!!! addCategory calling ref.read(dataProviderAsync.notifier).getAllServiceType(); !!!!!!!!!');
          // if (ref.context.mounted) {
          await dataNotifier.getAllServiceType();
          // }
          log('category added');

          NotificationHelper.showSuccessNotification('${apiResponse.message}');
        } else {
          NotificationHelper.showErrorNotification(
              'Failed to add category: ${apiResponse.message}');
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

  Future<void> updateCategory() async {
    log('*updateCategory called*');
    try {
      Map<String, dynamic> formData = {
        'name': state.categoryNameCtrl.text,
        'image': state.categoryForUpdate?.image ?? '',
      };

      // final data =
      //     await createFormData(imgXFile: state.imgXFile, formData: formData);
      final response = await service.updateItem(
          endpointUrl: 'categories',
          itemData: formData,
          itemId: state.categoryForUpdate?.sId ?? '');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        log('updateCategory responseBody =: ${responseBody} ');
        ApiResponse apiResponse = ApiResponse.fromJson(responseBody, null);
        if (apiResponse.success == true) {
          clearFields();
          NotificationHelper.showSuccessNotification('${apiResponse.message}');
          // Call fetch categories  _dataProvider.getAllCategory();
          await dataNotifier.getAllServiceType();

          log('category Updated');
        } else {
          NotificationHelper.showErrorNotification(
              'Failed to update category: ${apiResponse.message}');
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

  submitCategory() {
    if (state.categoryForUpdate != null) {
      updateCategory();
    } else {
      addCategory();
    }
  }

  Future<void> deleteCategory(Category category) async {
    try {
      final response = await service.deleteItem(
          endpointUrl: 'categories', itemId: category.sId ?? '');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        log('deleteCategory responseBody =: ${responseBody} ');
        ApiResponse apiResponse = ApiResponse.fromJson(responseBody, null);
        if (apiResponse.success == true) {
          // Call fetch categories _dataProvider.getAllCategory();
          await dataNotifier.getAllServiceType();

          NotificationHelper.showSuccessNotification(
              'Category Deleted Successfully');
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
  void setDataForUpdateCategory(Category? category) {
    log('setDataForUpdateCategory category =: ${category.toString()} ');

    if (category != null) {
      clearFields(); // Clear existing fields before setting new data
      state = state.copyWith(
        categoryForUpdate: category,
        categoryNameCtrl: TextEditingController(text: category.name ?? ''),
      );
    } else {
      clearFields(); // Clear fields if no category is passed
    }
  }

  void clearFields() {
    state.categoryNameCtrl.clear();
    state = state.copyWith(
        selectedImage: null, imgXFile: null, categoryForUpdate: null);
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  final httpService = ref.read(httpServiceProvider);
  final dataNotifier = ref.read(dataProviderAsync.notifier); // Get DataNotifier

  return CategoryNotifier(
      httpService, dataNotifier); // Pass DataNotifier to the constructor
});
