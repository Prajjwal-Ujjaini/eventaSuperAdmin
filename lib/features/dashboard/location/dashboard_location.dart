import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../main/main_layout.dart';
import '../dashboard_screen.dart';

class DashboardLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/dashboard'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    print(
        'DashboardLocation Current state path: ${state.uri.path}'); // Log the current path

    return [
      BeamPage(
        key: ValueKey('dashboard'),
        title: 'dashboard',
        child: MainLayout(
          currentIndex: 1,
          pageTitle: 'Dashboard',
          child: DashboardScreen(),
        ),
      ),
    ];
  }
}
