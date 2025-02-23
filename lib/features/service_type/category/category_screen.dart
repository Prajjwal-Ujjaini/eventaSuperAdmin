import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/constants.dart';
import '../../../core/data/data_provider.dart';
import 'components/add_category_form.dart';
import 'components/category_list_section.dart';
import 'components/middle_header.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

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
                        title: "My Categories",
                        searchHintText: "Categories",
                        onSearchChange: (val) {
                          print(val);
                          ref
                              .read(dataProviderAsync.notifier)
                              .filterServiceType(val);
                          // context.dataProvider.filterCategories(val);
                        },
                        onAddPressed: () {
                          print("Add new button pressed");
                          showAddCategoryForm(
                              context: context, ref: ref, category: null);
                        },
                        onRefreshPressed: () {
                          print("Refresh button pressed");
                          ref
                              .read(dataProviderAsync.notifier)
                              .getAllServiceType(showSnack: true);
                          // context.dataProvider.getAllCategory(showSnack: true);
                        },
                      ),
                      Gap(defaultPadding * 2),
                      CategoryListSection(),
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
