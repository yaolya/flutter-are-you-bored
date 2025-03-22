import 'dart:async';

import 'package:are_you_bored/data/models/activity.dart';
import 'package:are_you_bored/data/repositories/activity_repository.dart';
import 'package:are_you_bored/data/repositories/i_activity_repository.dart';

var mockActivity = const ActivityModel(
  id: 435236,
  text: "Water flowers",
  isSaved: false,
);
List<ActivityModel> _activitiesList = [];
ActivityModel? _currentActivity;

class ActivityRepositoryMock implements IActivityRepository {
  @override
  ActivityModel? get currentActivity => _currentActivity;

  @override
  List<ActivityModel>? get cachedActivities => _activitiesList;

  @override
  late Stream<ActivityRepositoryEvent> eventsStream;
  final _eventStreamController = StreamController<ActivityRepositoryEvent>();

  ActivityRepositoryMock() {
    eventsStream = _eventStreamController.stream.asBroadcastStream();
  }

  @override
  Future<ActivityModel> getRandomActivity() async {
    _currentActivity = mockActivity;
    return Future.delayed(const Duration(seconds: 2), () => mockActivity);
  }

  @override
  Future<List<ActivityModel>> getActivitiesList() async {
    return _activitiesList;
  }

  // @override
  // void addActivity(ActivitiesCompanion activity) {
  //   for (ActivitiesCompanion act in _activitiesList) {
  //     if (act == activity) {
  //       return;
  //     }
  //   }
  //   _activitiesList.add(activity);
  // }

  @override
  void addActivity(ActivityModel activity) async {
    _activitiesList.add(activity);
  }

  @override
  void deleteActivity(ActivityModel activity) {
    _activitiesList.removeWhere((e) => e.id == activity.id);
  }

  @override
  Future<bool> isSaved(int id) async {
    return false;
  }
}
