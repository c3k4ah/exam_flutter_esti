import 'dart:async';

import 'package:dartz/dartz.dart';

import '../main.dart';
import '../models/event.model.dart';
import '../utils/errors/failure.dart';

class EventProviders {
  Future<Either<Failure, EventModel>> addEvent(EventModel event) async {
    try {
      final eventModel = eventBox.event.putAndGetAsync(event);

      return eventModel.then((value) => Right(value));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteEvent(EventModel event) async {
    try {
      final isRemove = eventBox.event.remove(event.id);
      return Right(isRemove);
    } catch (e) {
      return Future.value(Left(Failure(message: e.toString())));
    }
  }

  Future<Either<Failure, EventModel>> updateEvent(EventModel event) async {
    try {
      final eventModel = eventBox.event.putAndGetAsync(event);

      return eventModel.then((value) => Right(value));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<EventModel>>> getEventsList() async {
    try {
      final events = await eventBox.event.getAllAsync();
      return Right(events);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  // Stream<List<EventModel>> watchEvent() {
  //   final query = eventBox.event.query().build();

  //   return query.find(EventModel_.);
  // }
}
