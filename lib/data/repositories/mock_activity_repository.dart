import 'dart:convert';

import 'package:first_app/data/repositories/i_activity_repository.dart';

import '../models/activity.dart';

var mockActivity = Activity(435236, "Water flowers");
List<Activity> activitiesList = [];

class MockActivityRepository implements IActivityRepository {
  @override
  Future<Activity> getRandomActivity() async =>
      Future.delayed(const Duration(seconds: 2), () => mockActivity);

  @override
  List<Activity> fetchActivities() {
    return activitiesList;
  }

  @override
  void addActivity(Activity activity) {
    for (Activity act in activitiesList) {
      if (act == activity) {
        return;
      }
    }
    activitiesList.add(activity);
  }
}
