import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/provider/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    // Wait for 2 seconds to simulate splash screen duration
    await Future.delayed(Duration(seconds: 2));

    // Check the authentication state and navigate accordingly
    final authState = ref.read(authProvider);
    if (authState.isAuthenticated) {
      // Navigate to dashboard if authenticated
      Beamer.of(context).beamToNamed('/dashboard');
    } else {
      // Navigate to login if not authenticated
      Beamer.of(context).beamToNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo or any widget for splash screen
            Image.asset(
              'assets/images/ValuexLogo.png', // Replace with your logo
              height: 150,
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
