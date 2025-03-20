import 'dart:async';
import 'dart:convert';

import 'package:are_you_bored/data/repositories/i_activity_repository.dart';
import 'package:are_you_bored/data/database/database_service.dart';

import '../network/activity_api.dart';
import '../models/activity.dart';

abstract class ActivityRepositoryEvent {}

class ActivityRepositoryCurrentActivityDeletedEvent
    extends ActivityRepositoryEvent {}

class ActivityRepository implements IActivityRepository {
  final ActivityAPI api;
  final DatabaseService dbService;
  Activity? _currentActivity;
  List<Activity>? _cachedActivities;

  @override
  late Stream<ActivityRepositoryEvent> eventsStream;
  // ignore: close_sinks
  final _eventsStreamController = StreamController<ActivityRepositoryEvent>();

  ActivityRepository({
    required this.api,
    required this.dbService,
  }) {
    eventsStream = _eventsStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Activity> getRandomActivity() async {
    final String rawActivity = await api.getRawActivity() ?? "";
    Map<String, dynamic> activityMap = jsonDecode(rawActivity);
    final activity = Activity.fromJson(activityMap);
    _currentActivity = activity;
    return activity;
  }

  @override
  Future<List<Activity>> getActivitiesList() async {
    final activities = await dbService.getActivitiesList();
    _cachedActivities = activities;
    return activities;
  }

  @override
  Activity? get currentActivity => _currentActivity;

  @override
  List<Activity>? get cachedActivities => _cachedActivities;

  @override
  void addActivity(Activity activity) async {
    dbService.addActivity(activity);
  }

  @override
  Future<bool> isSaved(Activity activity) async {
    return dbService.isSaved(activity);
  }

  @override
  void deleteActivity(Activity activity) async {
    dbService.deleteActivity(activity.id);
    if (activity == currentActivity) {
      _eventsStreamController
          .add(ActivityRepositoryCurrentActivityDeletedEvent());
    }
  }
}
