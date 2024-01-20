import 'dart:developer';

import 'constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
  }
}
