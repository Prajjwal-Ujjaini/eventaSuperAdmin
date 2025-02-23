import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/GlobalKeys.dart';
import 'core/routes/routes.dart';
import 'dependencies/app_dependencies.dart';
import 'features/auth/provider/auth_provider.dart';
import 'core/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the ProviderContainer
  final container = ProviderContainer();

  // Pass the container to AppDependencies
  final appDependencies = AppDependencies(container);

  runApp(
    ProviderScope(
      overrides: [
        appDependenciesProvider.overrideWithValue(appDependencies),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDependencies = ref.watch(appDependenciesProvider);
    final authCheckAsyncValue = ref.watch(authCheckProvider);
    return authCheckAsyncValue.when(
      data: (isAuthenticated) {
        final routerDelegate = createRouterDelegate(appDependencies);

        return MaterialApp.router(
          debugShowCheckedModeBanner: true,
          title: 'Flutter Admin Panel',
          scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerParser(),
        );
      },
      loading: () =>
          const CircularProgressIndicator(), // Show a loading indicator while checking auth
      error: (error, stackTrace) =>
          const Text('Error occurred'), // Handle errors appropriately
    );
  }
}
