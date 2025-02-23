// Screens
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/provider/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("PRofile screen");
    final authState = ref.watch(authProvider);

    if (authState.user == null) {
      return Center(child: CircularProgressIndicator()); // or a fallback UI
    }

    return Center(
      child: Text(
          'Welcome, ${authState.user?.name ?? 'User'} This is the Profile!'),
    );
  }
}
