import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  final VoidCallback onPressed;

  /// Creates a [RefreshButton] widget.
  ///
  /// The [onPressed] function is triggered when the button is tapped.
  /// It must not be null.
  const RefreshButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.refresh),
    );
  }
}
