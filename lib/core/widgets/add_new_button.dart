import 'package:flutter/material.dart';

import '../constants/constants.dart';

///// Usage with default icon and label
///AddNewButton(
///  onPressed: () {
///    showAddCategoryForm(context, null);
///  },
///),
///
///// Usage with a custom icon and label
///AddNewButton(
///  onPressed: () {
///    showAddCategoryForm(context, null);
///  },
///  icon: Icons.create, // Custom icon
///  label: "Create New", // Custom label
///),
class AddNewButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const AddNewButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add, // Default value for icon
    this.label = "Add New", // Default value for label
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon), // Use the passed or default icon parameter
      label: Text(label), // Use the passed or default label parameter
    );
  }
}
