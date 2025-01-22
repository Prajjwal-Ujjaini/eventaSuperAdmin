import 'package:beamer/beamer.dart';

import '../../dependencies/app_dependencies.dart';
import '../../features/auth/location/auth_location.dart';
import '../../features/dashboard/location/dashboard_location.dart';
import '../../features/service_type/location/service_type_location.dart';

BeamerDelegate createRouterDelegate(AppDependencies dependencies) {
  return BeamerDelegate(
    initialPath: '/login',
    transitionDelegate: NoAnimationTransitionDelegate(),
    guards: [
      BeamGuard(
        pathPatterns: ['/logout'],
        check: (context, location) {
          dependencies.authNotifier.logout();
          return false;
        },
        onCheckFailed: (context, location) {
          Beamer.of(context).beamToNamed('/login');
        },
      ),
      BeamGuard(
        pathPatterns: ['/dashboard', '/service-type'],
        check: (context, location) {
          final authState = dependencies.authNotifier.state;
          print('authState : $authState');
          return authState.isAuthenticated;
        },
        onCheckFailed: (context, location) {
          Beamer.of(context).beamToNamed('/login');
        },
      ),
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
