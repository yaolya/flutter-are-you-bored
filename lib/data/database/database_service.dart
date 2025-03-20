import 'package:are_you_bored/data/models/activity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  static const int _version = 1;
  static const String _dbName = "activities.db";
  static const String _activitiesTableName = "activity";
  static const String _activitiesKeyColumnName = "key";
  static const String _activitiesDescriptionColumnName = "description";

  DatabaseService._constructor();

  Future<Database> get database async => _db ??= await getDatabase();

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, _dbName);

    final database = await openDatabase(
      databasePath,
      version: _version,
      onCreate: (db, version) async {
        db.execute('''
        CREATE TABLE $_activitiesTableName (
          $_activitiesKeyColumnName INTEGER UNIQUE,
          $_activitiesDescriptionColumnName TEXT NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  void addActivity(Activity activity) async {
    final db = await database;
    await db.insert(
      _activitiesTableName,
      activity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> isSaved(Activity activity) async {
    final db = await database;
    var activities = await db.query(
      _activitiesTableName,
      where: 'key = ?',
      whereArgs: [activity.id],
    );
    return activities.isNotEmpty;
  }

  Future<List<Activity>> getActivitiesList() async {
    final db = await database;
    final data = await db.query(_activitiesTableName);
    List<Activity> activities =
        data.map((e) => Activity.fromDatabaseJson(e)).toList();
    return activities;
  }

  void deleteActivity(int key) async {
    final db = await database;
    await db.delete(
      _activitiesTableName,
      where: 'key = ?',
      whereArgs: [key],
    );
  }
}
