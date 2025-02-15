import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../presentation/forgot_password_screen.dart';
import '../presentation/login_screen.dart';
import '../provider/auth_provider.dart';
import '../presentation/signup_screen.dart';

class AuthLocation extends BeamLocation<BeamState> {
  final AuthNotifier authNotifier;

  AuthLocation({
    required this.authNotifier,
  });

  @override
  List<String> get pathPatterns =>
      ['/login', '/logout', '/signup', '/forgot-password'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    // // Handle logout
    // if (state.uri.path == '/logout') {
    //   authNotifier.logout();

    //   // Redirect to the login page after logout
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Beamer.of(context).beamToNamed('/login');
    //   });
    // }

    // Determine which screen to display based on the current path
    return [
      if (state.uri.path == '/signup')
        BeamPage(
          key: const ValueKey('signup'),
          title: 'Sign Up',
          child: SignupScreen(),
        )
      else if (state.uri.path == '/forgot-password')
        BeamPage(
          key: const ValueKey('forgot-password'),
          title: 'Forgot Password',
          child: ForgotPasswordScreen(),
        )
      else
        BeamPage(
          key: const ValueKey('login'),
          title: 'Login',
          child: LoginScreen(),
        ),
    ];
  }
}
