import 'dart:async';

import 'package:are_you_bored/data/repositories/activity_repository.dart';
import 'package:are_you_bored/data/repositories/i_activity_repository.dart';

import '../models/activity.dart';

var mockActivity = const Activity(
  id: 435236,
  text: "Water flowers",
  isSaved: false,
);
List<Activity> _activitiesList = [];
Activity? _currentActivity;

class ActivityRepositoryMock implements IActivityRepository {
  @override
  Activity? get currentActivity => _currentActivity;

  @override
  List<Activity>? get cachedActivities => _activitiesList;

  @override
  late Stream<ActivityRepositoryEvent> eventsStream;
  final _eventStreamController = StreamController<ActivityRepositoryEvent>();

  ActivityRepositoryMock() {
    eventsStream = _eventStreamController.stream.asBroadcastStream();
  }

  @override
  Future<Activity> getRandomActivity() async {
    _currentActivity = mockActivity;
    return Future.delayed(const Duration(seconds: 2), () => mockActivity);
  }

  @override
  Future<List<Activity>> getActivitiesList() async {
    return _activitiesList;
  }

  @override
  void addActivity(Activity activity) {
    for (Activity act in _activitiesList) {
      if (act == activity) {
        return;
      }
    }
    _activitiesList.add(activity);
  }

  @override
  void deleteActivity(Activity activity) {
    _activitiesList.removeWhere((e) => e.id == activity.id);
  }

  @override
  Future<bool> isSaved(Activity activity) async {
    return false;
  }
}
