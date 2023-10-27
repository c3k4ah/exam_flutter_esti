import 'package:get/get.dart';

import '../../providers/event.provider.dart';
import 'view_events.dart';

class ViewEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewEventController>(() => ViewEventController());
    Get.lazyPut<ObjectBox>(() => ObjectBox());
  }
}
