import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/routes.dart';
import 'dependencies/app_dependencies.dart';
import 'utility/constants.dart';

void main() {
  // Create an instance of AppDependencies to inject globally
  final appDependencies = AppDependencies();

  runApp(
    ProviderScope(
      overrides: [
        appDependenciesProvider.overrideWithValue(appDependencies),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDependencies = ref.watch(appDependenciesProvider);
    // final authState = ref.watch(authProvider);

    // final initialPath =
    //     authState.isAuthenticated ? '/dashboard' : '/login';

    final routerDelegate = createRouterDelegate(appDependencies);

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
