import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import '../../auth/provider/auth_provider.dart';
import '../provider/navigation_provider.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/ValuexLogo.png"),
          ),
          _buildDrawerTile(
            context,
            ref,
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            route: '/dashboard',
          ),
          _buildDrawerTile(
            context,
            ref,
            title: "Service Type",
            svgSrc: "assets/icons/menu_tran.svg",
            route: '/service-type',
          ),
          _buildLogoutTile(context, ref), // Separate logout tile
        ],
      ),
    );
  }

  Widget _buildDrawerTile(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String svgSrc,
    required String route,
  }) {
    return ListTile(
      onTap: () {
        ref.read(mainScreenProvider.notifier).navigateTo(route);
        Beamer.of(context).beamToNamed(route);
      },
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }

  // Create a separate widget for the logout tile
  Widget _buildLogoutTile(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () async {
        // Perform the logout asynchronously
        final authNotifier = ref.read(authProvider.notifier);
        await authNotifier.logout(); // Call your async logout function

        // Navigate to login after logout completes
        Beamer.of(context).beamToNamed('/login');
      },
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        "assets/icons/menu_notification.svg",
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: const Text(
        "Logout",
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
