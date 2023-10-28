import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';

import '../../providers/store.dart';
import 'view_events.dart';

class ViewEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewEventController>(() => ViewEventController());
    Get.lazyPut<ObjectBox>(() => ObjectBox());

    Get.lazyPut<EventController>(() => EventController());
  }
}
