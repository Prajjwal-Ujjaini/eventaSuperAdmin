import 'dart:developer';

import 'package:beamer/beamer.dart';

import '../../dependencies/app_dependencies.dart';
import '../../features/auth/location/auth_location.dart';
import '../../features/dashboard/location/dashboard_location.dart';
import '../../features/profile/location/profile_location.dart';
import '../../features/service_type/location/service_type_location.dart';
import '../../features/settings/location/settings_location.dart';
import '../../features/splash_screen/splash_location.dart';

BeamerDelegate createRouterDelegate(AppDependencies dependencies) {
  return BeamerDelegate(
    initialPath: '/splash', // Show splash screen first
    // transitionDelegate: NoAnimationTransitionDelegate(),
    // beamBackTransitionDelegate: ReverseTransitionDelegate(),

    guards: [
      BeamGuard(
        pathPatterns: ['/dashboard', '/service-type', '/profile', '/settings'],
        check: (context, location) {
          log('createRouterDelegate  /dashboard dependencies.authNotifier.state.isAuthenticated    =: ${dependencies.authNotifier.state.isAuthenticated} ');

          // Wait for the login check to finish
          if (dependencies.authNotifier.state.isLoading) {
            log('createRouterDelegate dependencies.authNotifier.state.isLoading    =: ${dependencies.authNotifier.state.isLoading} ');

            return false; // Still loading, prevent navigation
          }

          // Allow access if authenticated
          return dependencies.authNotifier.state.isAuthenticated;
        },
        onCheckFailed: (context, location) {
          if (dependencies.authNotifier.state.isLoading) {
            log('createRouterDelegate in onCheckFailed if dependencies.authNotifier.state.isLoading    =: ${dependencies.authNotifier.state.isLoading} ');

            // Instead of redirecting to '/splash', just prevent navigation and display a loading indicator in the UI
            return;
          } else {
            log('createRouterDelegate in onCheckFailed else beamToNamed  /login  =: ${dependencies.authNotifier.state.isLoading} ');
            // Redirect to login if not au
            // thenticated
            Beamer.of(context).beamToNamed('/login');
          }
        },
      ),
      BeamGuard(
        pathPatterns: ['/login', '/signup'],
        check: (context, location) {
          // Ensure that users who are already authenticated cannot access the login screen
          log('createRouterDelegate  /login !dependencies.authNotifier.state.isAuthenticated    =: ${!dependencies.authNotifier.state.isAuthenticated} ');

          // Ensure router waits for the login check to finish
          if (dependencies.authNotifier.state.isLoading) {
            return false; // Still loading, show splash or loading screen
          }

          return !dependencies.authNotifier.state.isAuthenticated;
        },
        onCheckFailed: (context, location) {
          Beamer.of(context).beamToNamed('/dashboard');
        },
      ),
      // BeamGuard(
      //   pathPatterns: ['/logout'],
      //   check: (context, location) {
      //     log('logout from routs');
      //     // dependencies.authNotifier.logout(); // Wait for the logout to complete
      //     return false; // Redirect after logging out
      //   },
      //   onCheckFailed: (context, location) {
      //     Beamer.of(context).beamToNamed('/login');
      //   },
      // ),
    ],
    locationBuilder: (routeInformation, _) {
      final beamLocations = [
        SplashLocation(),
        AuthLocation(authNotifier: dependencies.authNotifier),
        DashboardLocation(),
        ProfileLocation(),
        SettingsLocation(),
        ServiceTypeLocation(),
      ];

      return BeamerLocationBuilder(beamLocations: beamLocations).call(
        routeInformation,
        _,
      );
    },
  );
}
