import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'service_type_model.dart';

class ServiceTypeStateModel {
  final List<ServiceTypeModel> serviceTypes;
  final TextEditingController serviceTypeNameCtrl;
  final File? selectedImage;
  final XFile? imgXFile;
  final ServiceTypeModel? serviceTypeForUpdate;

  // Add this form key
  final GlobalKey<FormState> addServiceTypeFormKey;

  ServiceTypeStateModel({
    required this.serviceTypes,
    required this.serviceTypeNameCtrl,
    required this.selectedImage,
    required this.imgXFile,
    required this.serviceTypeForUpdate,
    required this.addServiceTypeFormKey, // Initialize in the constructor
  });

  factory ServiceTypeStateModel.initial() {
    return ServiceTypeStateModel(
      serviceTypes: [],
      serviceTypeNameCtrl: TextEditingController(),
      selectedImage: null,
      imgXFile: null,
      serviceTypeForUpdate: null,
      addServiceTypeFormKey: GlobalKey<FormState>(), // Initialize here as well
    );
  }

  ServiceTypeStateModel copyWith({
    List<ServiceTypeModel>? serviceTypes,
    TextEditingController? serviceTypeNameCtrl,
    File? selectedImage,
    XFile? imgXFile,
    ServiceTypeModel? serviceTypeForUpdate,
    bool? isLoading,
    GlobalKey<FormState>? addServiceTypeFormKey, // Add in copyWith
  }) {
    return ServiceTypeStateModel(
      serviceTypes: serviceTypes ?? this.serviceTypes,
      serviceTypeNameCtrl: serviceTypeNameCtrl ?? this.serviceTypeNameCtrl,
      selectedImage: selectedImage ?? this.selectedImage,
      imgXFile: imgXFile ?? this.imgXFile,
      serviceTypeForUpdate: serviceTypeForUpdate ?? this.serviceTypeForUpdate,
      addServiceTypeFormKey:
          addServiceTypeFormKey ?? this.addServiceTypeFormKey,
    );
  }

  @override
  String toString() {
    return 'ServiceTypeStateModel {serviceTypes: ${serviceTypes.toString()}, serviceTypeNameCtrl: ${serviceTypeNameCtrl.text.toString()}, selectedImage: $selectedImage, imgXFile: $imgXFile, serviceTypeForUpdate: $serviceTypeForUpdate, addServiceTypeFormKey: ${addServiceTypeFormKey.currentState}}';
  }
}
