import 'package:are_you_bored/data/models/activity.dart';
import 'package:are_you_bored/data/repositories/activity_repository.dart';

abstract class IActivityRepository {
  late Stream<ActivityRepositoryEvent> eventsStream;

  Future<ActivityModel> getRandomActivity();

  Future<List<ActivityModel>> getActivitiesList();

  ActivityModel? get currentActivity;

  List<ActivityModel>? get cachedActivities;

  Future<bool> isSaved(int id);

  void addActivity(ActivityModel activity);

  void deleteActivity(ActivityModel activity);
}
