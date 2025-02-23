import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/model/auth_state_model.dart';
import '../../auth/provider/auth_provider.dart';
import '../../../../core/constants/constants.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthState authState = ref.watch(authProvider);
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/ValuexLogo.png",
            height: 38,
          ),
          // Image.network(
          //   // authState.user?.profileImageUrl ?? // Profile Image URL
          //   //     'https://placehold.co/50', // Placeholder or user's image URL

          //   authState.user?.email ?? // Profile Image URL
          //       'https://placehold.co/50', // Placeholder or user's image URL
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text(authState.user?.name ?? 'User Name'),
          ),
          // IconButton(
          //   onPressed: () {
          //     Beamer.of(context).beamToNamed('/profile');
          //   },
          //   icon: Icon(Icons.keyboard_arrow_down),
          // ),
          IconButton(
            onPressed: () {
              _showProfileMenu(context, ref);
            },
            icon: Icon(Icons.keyboard_arrow_down),
          ),

          // Dropdown Button (Popup Menu)
          // Builder(
          //   builder: (popupContext) {
          //     return PopupMenuButton<String>(
          //       onSelected: (value) async {
          //         switch (value) {
          //           case 'profile':
          //             {
          //               log("Profile clicked");
          //               // Beamer.of(context).beamToNamed('/profile');
          //               Navigator.of(context).pushNamed('/profile');
          //             }
          //             break;
          //           case 'settings':
          //             {
          //               log("Settings clicked");
          //               Beamer.of(popupContext).beamToNamed('/settings');
          //             }
          //             break;
          //           case 'logout':
          //             {
          //               await ref.read(authProvider.notifier).logout();
          //               Beamer.of(popupContext).beamToNamed('/login');
          //             }
          //             break;
          //         }
          //       },
          //       itemBuilder: (context) => [
          //         PopupMenuItem(
          //           value: 'profile',
          //           child: Row(
          //             children: const [
          //               Icon(Icons.person, color: Colors.black),
          //               SizedBox(width: 8),
          //               Text('Profile'),
          //             ],
          //           ),
          //         ),
          //         PopupMenuItem(
          //           value: 'settings',
          //           child: Row(
          //             children: const [
          //               Icon(Icons.settings, color: Colors.black),
          //               SizedBox(width: 8),
          //               Text('Settings'),
          //             ],
          //           ),
          //         ),
          //         PopupMenuItem(
          //           value: 'logout',
          //           child: Row(
          //             children: const [
          //               Icon(Icons.logout, color: Colors.black),
          //               SizedBox(width: 8),
          //               Text('Logout'),
          //             ],
          //           ),
          //         ),
          //       ],
          //       icon: const Icon(
          //         Icons.keyboard_arrow_down,
          //         color: Colors.white,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final selected = await showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: const [
              Icon(Icons.person, color: Colors.black),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          child: Row(
            children: const [
              Icon(Icons.settings, color: Colors.black),
              SizedBox(width: 8),
              Text('Settings'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: const [
              Icon(Icons.logout, color: Colors.black),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
        ),
      ],
    );

    ///TODO:This future .dely is not good have to remove and check for diffrent solution
    /// when commenting
    /// // transitionDelegate: NoAnimationTransitionDelegate(),
    // beamBackTransitionDelegate: ReverseTransitionDelegate(),
    /// in router file also resolve this issue
    if (selected != null) {
      switch (selected) {
        case 'profile':
          log("Profile clicked");
          // Future.delayed(const Duration(milliseconds: 500))
          //     .then((value) => Beamer.of(context).beamToNamed('/profile'));

          Beamer.of(context).beamToNamed('/profile');

          break;
        case 'settings':
          log("Settings clicked");
          Future.delayed(const Duration(milliseconds: kDebugMode ? 200 : 0))
              .then((onValue) => Beamer.of(context).beamToNamed('/settings'));

          break;
        case 'logout':
          await ref.read(authProvider.notifier).logout();
          Beamer.of(context).beamToNamed('/login');
          break;
      }
    }
  }
}
