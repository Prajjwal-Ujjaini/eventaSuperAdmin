import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/add_new_button.dart';
import '../../../../core/widgets/refresh_button.dart';
import '../../../../core/widgets/search_field.dart';

class MiddleHeader extends StatelessWidget {
  final String title;
  final String searchHintText;
  final ValueChanged<String> onSearchChange;
  final VoidCallback onAddPressed;
  final VoidCallback onRefreshPressed;

  /// Creates a reusable [MiddleHeader] widget.
  ///
  /// - [title] is the text displayed on the left.
  /// - [searchHintText] is the hint text for the search field.
  /// - [onSearchChange] is a callback triggered when the search field changes.
  /// - [onAddPressed] is the callback for the add new button.
  /// - [onRefreshPressed] is the callback for the refresh button.
  const MiddleHeader({
    super.key,
    required this.title,
    required this.searchHintText,
    required this.onSearchChange,
    required this.onAddPressed,
    required this.onRefreshPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Spacer(flex: 2),
        Expanded(
          child: SearchField(
            hintText: searchHintText,
            onChange: onSearchChange,
          ),
        ),
        const Gap(28),
        AddNewButton(
          onPressed: onAddPressed,
        ),
        const Gap(20),
        RefreshButton(
          onPressed: onRefreshPressed,
        ),
      ],
    );
  }
}
