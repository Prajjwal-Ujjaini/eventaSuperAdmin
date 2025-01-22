import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
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
          _buildDrawerTile(
            context,
            ref,
            title: "logout",
            svgSrc: "assets/icons/menu_notification.svg",
            route: '/logout',
          ),
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
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
