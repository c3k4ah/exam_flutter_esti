import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../objectbox.g.dart';
import '../models/event.model.dart';

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
