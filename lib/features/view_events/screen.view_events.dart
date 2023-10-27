import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/event.model.dart';
import 'view_events.dart';
import 'widgets/alertdialog.dart';
import 'widgets/event.widget.dart';

class ViewEventSreen extends GetView<ViewEventController> {
  static const route = "/calendar-view";
  const ViewEventSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Calendar View',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(const AddEventPopUp());
            },
            icon: const Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(10),
                height: MediaQuery.sizeOf(context).height * .55,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: MonthView(
                  controller: EventController(),
                  showBorder: false,
                  headerBuilder: (date) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '${date.month} - ${date.year}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                  cellBuilder: (date, events, isToday, isInMonth) {
                    return Obx(
                      () {
                        DateTime dateEvent = controller.dateEvent.value;
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isInMonth
                                ? (dateEvent.day == date.day &&
                                        dateEvent.month == date.month
                                    ? Colors.blue
                                    : Colors.white)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              color: isInMonth
                                  ? (isToday
                                      ? ((dateEvent.day == date.day &&
                                              dateEvent.month == date.month
                                          ? Colors.white
                                          : Colors.red))
                                      : (dateEvent.day == date.day &&
                                              dateEvent.month == date.month
                                          ? Colors.white
                                          : Colors.black))
                                  : Colors.grey.withOpacity(.3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  minMonth: DateTime(1990),
                  maxMonth: DateTime(2050),
                  initialMonth: DateTime.now(),
                  cellAspectRatio: 1,
                  onCellTap: (events, date) {
                    controller.dateEvent(date);
                  },
                  startDay: WeekDays.monday,
                  onEventTap: (event, date) => print(event),
                  onDateLongPress: (date) => print(date),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.transparent,
                child: Obx(() => ListView.builder(
                      itemCount: controller.events.length,
                      itemBuilder: (context, index) {
                        EventModel event = controller.events[index];
                        return EventWidget(
                          onPressed: () {
                            controller.deleteOneEvent(event: event);
                          },
                          event: event,
                        );
                      },
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
