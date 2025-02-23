import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/data/data_provider.dart';
import '../category.dart';
import '../provider/category_provider.dart';
import 'add_category_form.dart';

class CategoryListSection extends ConsumerWidget {
  const CategoryListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the async data provider
    final dataState =
        ref.watch(dataProviderAsync); // Make sure to watch the correct provider

    log('@@@@@@@@@@@@@@@@@@@@ dataState : ${dataState} @@@@@@@@@@@@@@@@@@@@');

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Categories",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: dataState.when(
              // Handle different states using Riverpod's dataState
              data: (data) {
                // Replace 'data.categories' with 'data.filteredServiceType' or 'data.allServiceType'
                final categories =
                    data.filteredServiceType; // or use allServiceType if needed

                log('@@ categories : ${categories} @@@');
                log('@@ categories.length : ${categories.length} @@@');

                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Category Name"),
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
                    categories.length,
                    (index) =>
                        categoryDataRow(categories[index], delete: () async {
                      await ref.read(categoryProvider.notifier).deleteCategory(
                          categories[index], ref); // Use ref.read to delete
                      if (context.mounted) {
                        // Handle any post-delete UI changes (if needed)
                        // For example: showing a success notification or refreshing the UI
                      }
                    }, edit: () {
                      if (context.mounted) {
                        showAddCategoryForm(
                            context: context,
                            ref: ref,
                            category: categories[index]);
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

DataRow categoryDataRow(Category CatInfo, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              CatInfo.image ?? '',
              height: 30,
              width: 30,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(CatInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(CatInfo.createdAt ?? '')),
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
