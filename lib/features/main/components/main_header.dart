import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/search_field.dart';
import './profile_card.dart';

class MainHeader extends ConsumerWidget {
  final String pageTitle;

  const MainHeader({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          pageTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Spacer(flex: 1),
        Expanded(child: SearchField(
          onChange: (val) {
            print(val);
            // context.dataProvider.filterCategories(val);
          },
        )),
        ProfileCard()
      ],
    );
  }
}
