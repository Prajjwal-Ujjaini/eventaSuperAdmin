// Screens
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/provider/auth_provider.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${authState.userName ?? 'User'}'),
      ),
      body: Center(
        child: Text('This is the dashboard!'),
      ),
    );
  }
}
