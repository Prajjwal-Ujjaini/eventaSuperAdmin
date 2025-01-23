import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/routes.dart';
import 'dependencies/app_dependencies.dart';
import 'utility/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app dependencies
  final appDependencies = AppDependencies();

  // Check login status before running the app
  final isAuthenticated = await appDependencies.authService.isAuthenticated();

  runApp(
    ProviderScope(
      overrides: [
        appDependenciesProvider.overrideWithValue(appDependencies),
      ],
      child: MyApp(isAuthenticated: isAuthenticated),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final bool isAuthenticated;

  const MyApp({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDependencies = ref.watch(appDependenciesProvider);
    final routerDelegate =
        createRouterDelegate(appDependencies, isAuthenticated);

    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}
