import 'dart:developer';
import 'package:eventa_super_admin/features/service_type/model/service_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/data/data_provider.dart';
import '../provider/service_type_provider.dart';
import 'add_service_type_form.dart';

class ServiceTypeListSection extends ConsumerWidget {
  const ServiceTypeListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the async data provider
    final dataState =
        ref.watch(dataProviderAsync); // Make sure to watch the correct provider

    log('@@@@@@@@@@@@@@@@@@@@ dataState : $dataState @@@@@@@@@@@@@@@@@@@@');

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All ServiceType",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // Add category count here
              dataState.maybeWhen(
                data: (data) {
                  final categoryCount = data.filteredServiceType.length;
                  return Padding(
                    padding: const EdgeInsets.only(right: defaultPadding),
                    child: Text(
                      "Total: $categoryCount",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                  );
                },
                orElse: () => SizedBox.shrink(),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: dataState.when(
              // Handle different states using Riverpod's dataState
              data: (data) {
                final serviceTypes =
                    data.filteredServiceType; // or use allServiceType if needed

                log('@@ serviceTypes : $serviceTypes @@@');
                log('@@ serviceTypes.length : ${serviceTypes.length} @@@');

                return DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("ServiceType Name"),
                    ),
                    DataColumn(
                      label: Text("Added Date"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    serviceTypes.length,
                    (index) => serviceTypeDataRow(serviceTypes[index],
                        delete: () async {
                      await ref
                          .read(serviceTypeProvider.notifier)
                          .deleteServiceType(
                              serviceTypes[index]); // Use ref.read to delete
                      if (context.mounted) {
                        // Handle any post-delete UI changes (if needed)
                      }
                    }, edit: () {
                      if (context.mounted) {
                        showAddServiceTypeForm(
                            context: context,
                            ref: ref,
                            serviceType: serviceTypes[index]);
                      }
                    }),
                  ),
                );
              },
              loading: () => Center(
                  child: CircularProgressIndicator()), // Handle loading state
              error: (error, stack) =>
                  Center(child: Text('Error: $error')), // Handle error state
            ),
          ),
        ],
      ),
    );
  }
}

DataRow serviceTypeDataRow(ServiceTypeModel serviceType,
    {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              serviceType.image ?? '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(serviceType.serviceTypeName ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(serviceType.createdAt ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
