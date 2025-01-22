import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
import '../provider/auth_provider.dart';

class AuthLocation extends BeamLocation<BeamState> {
  final AuthNotifier authNotifier;

  AuthLocation({
    required this.authNotifier,
  });

  @override
  List<String> get pathPatterns => ['/login', '/logout'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    if (state.uri.path == '/logout') {
      authNotifier.logout();
    }

    return [
      BeamPage(
        key: const ValueKey('login'),
        title: 'Login',
        child: LoginScreen(),
      ),
    ];
  }
}
