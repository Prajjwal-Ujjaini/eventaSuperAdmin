import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../model/service_type_model.dart';
import '../provider/service_type_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/widgets/service_type_image_card.dart';
import '../../../core/widgets/custom_text_field.dart';

class ServiceTypeSubmitForm extends ConsumerWidget {
  final ServiceTypeModel? serviceType;

  const ServiceTypeSubmitForm({super.key, this.serviceType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    // Access the ServiceTypeProvider using ref.watch
    final svrcTypeProvider = ref.watch(serviceTypeProvider);

    return SingleChildScrollView(
      child: Form(
        key: ref.read(serviceTypeProvider).addServiceTypeFormKey,
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
              ServiceTypeImageCard(
                labelText: "ServiceType",
                imageFile: svrcTypeProvider.selectedImage,
                imageUrlForUpdateImage: serviceType?.image,
                onTap: () {
                  ref.read(serviceTypeProvider.notifier).pickImage();
                },
              ),
              Gap(defaultPadding),
              CustomTextField(
                controller: ref.read(serviceTypeProvider).serviceTypeNameCtrl,
                labelText: 'ServiceType Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a serviceType name';
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
                          .read(serviceTypeProvider)
                          .addServiceTypeFormKey
                          .currentState!
                          .validate()) {
                        ref
                            .read(serviceTypeProvider)
                            .addServiceTypeFormKey
                            .currentState!
                            .save();
                        await ref
                            .read(serviceTypeProvider.notifier)
                            .submitServiceType();

                        if (context.mounted) {
                          log('context.mounted');
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

// How to show the serviceType popup
void showAddServiceTypeForm(
    {required BuildContext context,
    required WidgetRef ref,
    ServiceTypeModel? serviceType}) {
  // Call setDataForUpdateServiceType before showing the form

  log('showAddServiceTypeForm serviceType =: ${serviceType.toString()} ');

  ref
      .read(serviceTypeProvider.notifier)
      .setDataForUpdateServiceType(serviceType);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Add ServiceType'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: ServiceTypeSubmitForm(serviceType: serviceType),
      );
    },
  );
}
