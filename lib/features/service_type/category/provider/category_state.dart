import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../category.dart';

class CategoryState {
  final List<Category> categories;
  final TextEditingController categoryNameCtrl;
  final File? selectedImage;
  final XFile? imgXFile;
  final Category? categoryForUpdate;

  // Add this form key
  final GlobalKey<FormState> addCategoryFormKey;

  CategoryState({
    required this.categories,
    required this.categoryNameCtrl,
    required this.selectedImage,
    required this.imgXFile,
    required this.categoryForUpdate,
    required this.addCategoryFormKey, // Initialize in the constructor
  });

  factory CategoryState.initial() {
    return CategoryState(
      categories: [],
      categoryNameCtrl: TextEditingController(),
      selectedImage: null,
      imgXFile: null,
      categoryForUpdate: null,
      addCategoryFormKey: GlobalKey<FormState>(), // Initialize here as well
    );
  }

  CategoryState copyWith({
    List<Category>? categories,
    TextEditingController? categoryNameCtrl,
    File? selectedImage,
    XFile? imgXFile,
    Category? categoryForUpdate,
    bool? isLoading,
    GlobalKey<FormState>? addCategoryFormKey, // Add in copyWith
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      categoryNameCtrl: categoryNameCtrl ?? this.categoryNameCtrl,
      selectedImage: selectedImage ?? this.selectedImage,
      imgXFile: imgXFile ?? this.imgXFile,
      categoryForUpdate: categoryForUpdate ?? this.categoryForUpdate,
      addCategoryFormKey: addCategoryFormKey ?? this.addCategoryFormKey,
    );
  }
}
