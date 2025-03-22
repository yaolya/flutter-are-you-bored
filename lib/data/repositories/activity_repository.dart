import 'dart:async';
import 'dart:convert';

import 'package:are_you_bored/data/models/activity.dart';
import 'package:are_you_bored/data/repositories/i_activity_repository.dart';
import 'package:are_you_bored/data/database/database_service.dart';

import '../network/activity_api.dart';

abstract class ActivityRepositoryEvent {}

class ActivityRepositoryCurrentActivityDeletedEvent
    extends ActivityRepositoryEvent {}

class ActivityRepository implements IActivityRepository {
  final ActivityAPI api;
  final DatabaseService dbService;
  ActivityModel? _currentActivity;
  List<ActivityModel>? _cachedActivities;

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
  Future<ActivityModel> getRandomActivity() async {
    final String rawActivity = await api.getRawActivity() ?? "";
    Map<String, dynamic> activityMap = jsonDecode(rawActivity);
    final activity = ActivityModel.fromJson(activityMap);
    _currentActivity = activity;
    return activity;
  }

  @override
  Future<List<ActivityModel>> getActivitiesList() async {
    final activities = await dbService.getActivitiesList();
    final act = activities.map((e) {
      return ActivityModel.fromDatabaseActivity(e);
    }).toList();
    _cachedActivities = act;
    return act;
  }

  @override
  ActivityModel? get currentActivity => _currentActivity;

  @override
  List<ActivityModel>? get cachedActivities => _cachedActivities;

  @override
  void addActivity(ActivityModel activity) async {
    dbService.addActivity(activity);
  }

  @override
  Future<bool> isSaved(int id) async {
    return dbService.isSaved(id);
  }

  @override
  void deleteActivity(ActivityModel activity) async {
    dbService.deleteActivity(activity.id);
    if (activity == currentActivity) {
      _eventsStreamController
          .add(ActivityRepositoryCurrentActivityDeletedEvent());
    }
  }
}
