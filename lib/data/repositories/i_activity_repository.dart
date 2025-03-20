import 'package:are_you_bored/data/repositories/activity_repository.dart';

import '../models/activity.dart';

abstract class IActivityRepository {
  late Stream<ActivityRepositoryEvent> eventsStream;

  Future<Activity> getRandomActivity();

  Future<List<Activity>> getActivitiesList();

  Activity? get currentActivity;

  List<Activity>? get cachedActivities;

  Future<bool> isSaved(Activity activity);

  void addActivity(Activity activity);

  void deleteActivity(Activity activity);
}
