import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../main/main_layout.dart';
import '../presentation/profile_screen.dart';

class ProfileLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/profile'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    print(
        'ProfileLocation Current state path: ${state.uri.path}'); // Log the current path

    return [
      BeamPage(
        key: ValueKey('profile'),
        title: 'profile',
        child: MainLayout(
          currentIndex: 1,
          pageTitle: 'Profile',
          child: ProfileScreen(),
        ),
      ),
    ];
  }
}
