import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';

class SplashLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/splash'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    print(
        'SplashLocation Current state path: ${state.uri.path}'); // Log the current path

    return [
      BeamPage(
        key: ValueKey('splash'),
        title: 'splash',
        child: SplashScreen(),
      ),
    ];
  }
}
