import 'package:drift/drift.dart';

class Activities extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get key => integer()();
  TextColumn get content => text()();
  BoolColumn get isSaved => boolean()();
}
