import 'package:beamer/beamer.dart';
import 'package:eventa_super_admin/features/service_type/services_screen.dart';
import 'package:flutter/material.dart';

import '../../main/main_layout.dart';

class ServiceTypeLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/service-type'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('service-type'),
        title: 'service-type',
        child: MainLayout(
          currentIndex: 1,
          child: ServiceTypeScreen(),
        ),
      ),
    ];
  }
}
