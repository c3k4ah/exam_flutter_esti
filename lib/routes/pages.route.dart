import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/view_events/view_events.dart';

Transition transition = Transition.fadeIn;

class AppPages {
  static String initialRoute = ViewEventSreen.route;

  static final routes = <GetPage>[
    GetPage(
      name: ViewEventSreen.route,
      page: () => const ViewEventSreen(),
      binding: ViewEventBinding(),
      transition: transition,
      curve: Curves.easeIn,
    ),
  ];
}
