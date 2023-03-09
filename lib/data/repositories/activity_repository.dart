import 'dart:convert';

import 'package:first_app/data/repositories/i_activity_repository.dart';

import '../data_providers/activity_api.dart';
import '../models/activity.dart';

class ActivityRepository implements IActivityRepository {
  final ActivityAPI api;
  final List<Activity> activities = [];
  Activity? currentActivity;

  ActivityRepository({required this.api});

  @override
  Future<Activity> getRandomActivity() async {
    final String rawActivity = await api.getRawActivity();
    Map<String, dynamic> activityMap = jsonDecode(rawActivity);
    final Activity activity = Activity.fromJson(activityMap);
    currentActivity = activity;
    return activity;
  }

  @override
  List<Activity> fetchActivities() {
    return activities;
  }

  @override
  Activity? getCurrentActivity() {
    return currentActivity;
  }

  @override
  void addActivity(Activity activity) {
    for (Activity act in activities) {
      if (act == activity) {
        return;
      }
    }
    activities.add(activity);
  }
}
