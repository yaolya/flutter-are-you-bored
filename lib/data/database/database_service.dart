import 'package:are_you_bored/data/database/drift_database.dart';
import 'package:are_you_bored/data/models/activity.dart';
import 'package:are_you_bored/locator.dart';
import 'package:drift/drift.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  AppDatabase db = locator.get<AppDatabase>();
  DatabaseService._constructor();

  void addActivity(ActivityModel activity) async {
    ActivitiesCompanion ac = ActivitiesCompanion(
      key: Value(activity.id),
      content: Value(activity.text),
      isSaved: Value(activity.isSaved),
    );
    await db.into(db.activities).insert(ac);
  }

  Future<bool> isSaved(int id) async {
    final resultActivity = await (db.select(db.activities)
          ..where((a) => a.key.equals(id)))
        .getSingleOrNull();
    return resultActivity?.isSaved ?? false;
  }

  Future<List<Activity>> getActivitiesList() async {
    final activities = await db.select(db.activities).get();
    return activities;
  }

  void deleteActivity(int key) async {
    await (db.delete(db.activities)..where((a) => a.key.equals(key))).go();
  }
}
