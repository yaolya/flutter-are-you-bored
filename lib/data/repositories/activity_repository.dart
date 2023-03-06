import 'dart:convert';

import '../data_providers/activity_api.dart';
import '../models/activity.dart';

class ActivityRepository {
  final ActivityAPI api;
  final List<Activity> activities = [];

  ActivityRepository({required this.api});

  Future<Activity> getRandomActivity() async {
    final String rawActivity = await api.getRawActivity();
    Map<String, dynamic> activityMap = jsonDecode(rawActivity);
    final Activity activity = Activity.fromJson(activityMap);
    return activity;
  }

  List<Activity> fetchActivities() {
    return activities;
  }

  void addActivity(Activity activity) {
    for (Activity act in activities) {
      if (act == activity) {
        return;
      }
    }
    activities.add(activity);
  }
}
