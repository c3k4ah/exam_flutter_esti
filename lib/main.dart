// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'providers/store.dart';
import 'routes/pages.route.dart';

late ObjectBox eventBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  eventBox = await ObjectBox.create();

  runApp(const MyApp(
      // box: eventBox,
      ));
}

class MyApp extends StatelessWidget {
  // final ObjectBox box;
  const MyApp({
    Key? key,
    // required this.box,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: GetMaterialApp(
        title: 'Calendar View',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: AppPages.initialRoute,
        defaultTransition: Transition.noTransition,
        getPages: AppPages.routes,
      ),
    );
  }
}
