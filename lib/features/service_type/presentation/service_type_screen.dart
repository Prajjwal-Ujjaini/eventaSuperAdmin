import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/constants.dart';
import '../../../core/data/data_provider.dart';
import '../components/add_service_type_form.dart';
import '../components/service_type_list_section.dart';
import '../../../core/widgets/middle_header.dart';

class ServiceTypeScreen extends ConsumerWidget {
  const ServiceTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MiddleHeader(
                        title: "My ServiceTypes",
                        searchHintText: "ServiceTypes",
                        onSearchChange: (val) {
                          print(val);
                          ref
                              .read(dataProviderAsync.notifier)
                              .filterServiceType(val);
                        },
                        onAddPressed: () {
                          print("Add new button pressed");
                          showAddServiceTypeForm(
                              context: context, ref: ref, serviceType: null);
                        },
                        onRefreshPressed: () {
                          print("Refresh button pressed");
                          ref
                              .read(dataProviderAsync.notifier)
                              .getAllServiceType(showSnack: true);
                        },
                      ),
                      Gap(defaultPadding * 2),
                      ServiceTypeListSection(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
