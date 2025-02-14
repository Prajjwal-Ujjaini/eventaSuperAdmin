import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/routes.dart';
import 'dependencies/app_dependencies.dart';
import 'features/auth/provider/auth_provider.dart';
import 'utility/constants.dart';
import 'utility/notification_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDependencies = AppDependencies();

  runApp(
    ProviderScope(
      overrides: [
        appDependenciesProvider.overrideWithValue(appDependencies),
      ],
      child: const MyApp(), // Remove the isAuthenticated parameter
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
          scaffoldMessengerKey: NotificationHelper.scaffoldMessengerKey,
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
