import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../category.dart';
import '../provider/category_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/category_image_card.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CategorySubmitForm extends ConsumerWidget {
  final Category? category;

  const CategorySubmitForm({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    // Access the CategoryProvider using ref.watch
    final catProvider = ref.watch(categoryProvider);

    return SingleChildScrollView(
      child: Form(
        key: ref.read(categoryProvider).addCategoryFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              CategoryImageCard(
                labelText: "Category",
                imageFile: catProvider.selectedImage,
                imageUrlForUpdateImage: category?.image,
                onTap: () {
                  ref.read(categoryProvider.notifier).pickImage();
                },
              ),
              Gap(defaultPadding),
              CustomTextField(
                controller: ref.read(categoryProvider).categoryNameCtrl,
                labelText: 'Category Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () async {
                      // Validate and save the form
                      if (ref
                          .read(categoryProvider)
                          .addCategoryFormKey
                          .currentState!
                          .validate()) {
                        ref
                            .read(categoryProvider)
                            .addCategoryFormKey
                            .currentState!
                            .save();
                        await ref
                            .read(categoryProvider.notifier)
                            .submitCategory(ref);

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the category popup
void showAddCategoryForm(
    {required BuildContext context,
    required WidgetRef ref,
    Category? category}) {
  // Call setDataForUpdateCategory before showing the form

  log('showAddCategoryForm category =: ${category.toString()} ');

  ref.read(categoryProvider.notifier).setDataForUpdateCategory(category);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Add Category'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: CategorySubmitForm(category: category),
      );
    },
  );
}
