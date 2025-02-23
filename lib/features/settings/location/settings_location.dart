import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../main/main_layout.dart';
import '../presentation/settings_screen.dart';

class SettingsLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/settings'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    print(
        'SettingsLocation Current state path: ${state.uri.path}'); // Log the current path

    return [
      BeamPage(
        key: ValueKey('settings'),
        title: 'settings',
        child: MainLayout(
          currentIndex: 1,
          pageTitle: 'settings',
          child: SettingsScreen(),
        ),
      ),
    ];
  }
}
