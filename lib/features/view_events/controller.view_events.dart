import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/event.model.dart';
import '../../objectbox.g.dart';
import '../../providers/event.provider.dart';

class ViewEventController extends GetxController {
  final EventProviders _eventBox = EventProviders();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriController = TextEditingController();
  Rx<DateTime> dateEvent = DateTime.now().obs;
  Rx<DateTime> timeEvent = DateTime.now().obs;
  RxList<EventModel> events = <EventModel>[].obs;
  RxInt colorEvent = Colors.deepOrange.value.obs;

  List<Color> couleurs = [
    Colors.deepOrange,
    Colors.green.shade900,
    Colors.blue.shade900,
    Colors.teal,
    Colors.purpleAccent,
  ];
  @override
  Future<void> onInit() async {
    await getAllEvents();
    watchEvent().listen((event) {
      events(event);
    });
    super.onInit();
  }

  getAllEvents() async {
    final result = await _eventBox.getEventsList();
    result.fold((l) => printError(info: l.toString()), (r) {
      events(r);
    });
  }

  Future<bool> deleteOneEvent({required EventModel event}) async {
    final result = await _eventBox.deleteEvent(event);
    bool isDone = false;
    result.fold(
      (l) => printError(info: l.message),
      (r) {
        isDone = r;
        events.removeWhere((element) => event.id == element.id);
        printInfo(info: 'Done');
      },
    );
    return isDone;
  }

  Future<EventModel> addOneEvent() async {
    final event = EventModel(
      title: titleController.text,
      description: descriController.text,
      date: dateEvent.value,
      time: dateEvent.value,
      color: colorEvent.value,
    );
    final result = await _eventBox.addEvent(event);
    EventModel isDone = EventModel.defaultData();
    result.fold(
      (l) => printError(info: l.message),
      (r) {
        isDone = r;
        cleanUp();
      },
    );
    return isDone;
  }

  Stream<List<EventModel>> watchEvent() {
    final query = eventBox.event.query().order(
          EventModel_.date,
        );
    return query.watch(triggerImmediately: true).map((query) => query.find());
  }

  myTimePicker() async {
    TimeOfDay nowTime = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: nowTime,
    );
    if (pickedTime != null) {
      timeEvent(DateTime(
        dateEvent.value.year,
        dateEvent.value.month,
        dateEvent.value.day,
        pickedTime.hour,
        pickedTime.minute,
      ));
    }
  }

  cleanUp() {
    titleController.clear();
    descriController.clear();
    dateEvent(DateTime.now());
    timeEvent(DateTime.now());
    Get.back();
  }
}
