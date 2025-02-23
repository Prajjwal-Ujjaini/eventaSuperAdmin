import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/constants/constants.dart';
import 'components/main_header.dart';
import 'components/side_menu.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final String pageTitle; // Add pageName parameter

  const MainLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.pageTitle, // Add this parameter to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: MainHeader(
                      pageTitle: pageTitle, // Pass pageName to the header
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: child,
                    ),
                  ), // Display the child widget (actual content)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
