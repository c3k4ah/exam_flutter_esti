import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/event.model.dart';
import 'providers/event.provider.dart';
import 'routes/pages.route.dart';

late ObjectBox eventBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  eventBox = await ObjectBox.create();
  // eventBox.event.putAndGetManyAsync([
  //   EventModel(
  //     title: 'Event 1',
  //     description: 'Description 1',
  //     date: DateTime.now(),
  //     time: DateTime.now(),
  //     color: Colors.amber.value,
  //   ),
  //   EventModel(
  //     title: 'Event 2',
  //     description: 'Description 2',
  //     date: DateTime.now().add(const Duration(days: -1)),
  //     time: DateTime.now().add(const Duration(days: -1)),
  //     color: Colors.blue.value,
  //   ),
  //   EventModel(
  //     title: 'Event 3',
  //     description: 'Description 3',
  //     date: DateTime.now().add(const Duration(days: -2)),
  //     time: DateTime.now().add(const Duration(days: -2)),
  //     color: Colors.red.value,
  //   ),
  //   EventModel(
  //     title: 'Event 4',
  //     description: 'Description 4',
  //     date: DateTime.now().add(const Duration(days: -3)),
  //     time: DateTime.now().add(const Duration(days: -3)),
  //     color: Colors.purpleAccent.value,
  //   ),
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: GetMaterialApp(
        title: 'Calendar View',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppPages.initialRoute,
        defaultTransition: Transition.noTransition,
        getPages: AppPages.routes,
      ),
    );
  }
}
