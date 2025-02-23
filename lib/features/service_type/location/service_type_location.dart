import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../main/main_layout.dart';
import '../category/category_screen.dart';

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
          pageTitle: 'Service Type',
          // child: ServiceTypeListScreen(),
          child: CategoryScreen(),
        ),
      ),
    ];
  }
}
