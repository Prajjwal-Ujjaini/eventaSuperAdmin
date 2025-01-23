import 'package:beamer/beamer.dart';

import '../../dependencies/app_dependencies.dart';
import '../../features/auth/location/auth_location.dart';
import '../../features/dashboard/location/dashboard_location.dart';
import '../../features/service_type/location/service_type_location.dart';

BeamerDelegate createRouterDelegate(
    AppDependencies dependencies, bool isAuthenticated) {
  return BeamerDelegate(
    initialPath: isAuthenticated ? '/dashboard' : '/login',
    transitionDelegate: NoAnimationTransitionDelegate(),
    guards: [
      BeamGuard(
        pathPatterns: ['/dashboard', '/service-type'],
        check: (context, location) {
          return dependencies.authNotifier.state.isAuthenticated;
        },
        onCheckFailed: (context, location) {
          Beamer.of(context).beamToNamed('/login');
        },
      ),
      BeamGuard(
        pathPatterns: ['/login'],
        check: (context, location) {
          return !dependencies.authNotifier.state.isAuthenticated;
        },
        onCheckFailed: (context, location) {
          Beamer.of(context).beamToNamed('/dashboard');
        },
      ),

      // BeamGuard(
      //   pathPatterns: ['/logout'],
      //   check: (context, location) {
      //     dependencies.authNotifier.logout();
      //     return false;
      //   },
      //   onCheckFailed: (context, location) {
      //     Beamer.of(context).beamToNamed('/login');
      //   },
      // ),
    ],
    locationBuilder: (routeInformation, _) {
      final beamLocations = [
        AuthLocation(authNotifier: dependencies.authNotifier),
        DashboardLocation(),
        ServiceTypeLocation(),
      ];

      return BeamerLocationBuilder(beamLocations: beamLocations).call(
        routeInformation,
        _,
      );
    },
  );
}
