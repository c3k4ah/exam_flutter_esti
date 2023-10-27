import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class EventModel {
  EventModel({
    this.id = 0,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.color,
  });

  @Id(assignable: true)
  int id;

  @Property()
  String title;
  @Property()
  String description;
  @Property(type: PropertyType.date)
  DateTime date;
  @Property(type: PropertyType.date)
  DateTime time;
  @Property(type: PropertyType.int)
  int color;

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, description: $description, date: $date, time: $time, color: $color';
  }

  EventModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    DateTime? time,
    int? color,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'time': time.millisecondsSinceEpoch,
      'color': color,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map /*, {int? id}*/) {
    return EventModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      color: map['color'] as int,
    );
  }
  // from CalendarEventData
  factory EventModel.fromCalendarEventData(
      CalendarEventData calendarEventData) {
    return EventModel(
      title: calendarEventData.title,
      description: calendarEventData.description,
      date: calendarEventData.date,
      time: calendarEventData.date,
      color: calendarEventData.color.value,
    );
  }
  // to CalendarEventData
  CalendarEventData toCalendarEventData() {
    return CalendarEventData(
      title: title,
      description: description,
      date: date,
      color: Color(color),
    );
  }

  factory EventModel.defaultData() {
    return EventModel(
      title: 'Defaut',
      description: 'Data par defaut',
      date: DateTime.now(),
      color: Colors.red.value,
      time: DateTime.now(),
    );
  }
}
