import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:dartz/dartz.dart';

import '../main.dart';
import '../models/event.model.dart';
import '../objectbox.g.dart';
import '../utils/errors/failure.dart';

class ObjectBox {
  late final Store store;

  late Box<EventModel> event = Box<EventModel>(store);
  ObjectBox();
  ObjectBox._create(this.store) {
    event = Box<EventModel>(store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    final store =
        await openStore(directory: p.join(docsDir.path, "event_store"));
    return ObjectBox._create(store);
  }
}

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

  Stream<List<EventModel>> watchEvent() {
    final query = eventBox.event.query().order(
          EventModel_.date,
        );

    return query.watch(triggerImmediately: true).map((query) => query.find());
  }
}
