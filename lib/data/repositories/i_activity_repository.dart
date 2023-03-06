import '../models/activity.dart';

abstract class IActivityRepository {
  // final IActivityAPI api;
  // final List<Activity> activities = [];

  // IActivityRepository({required this.api});

  Future<Activity> getRandomActivity();

  List<Activity> fetchActivities();

  void addActivity(Activity activity);
}
