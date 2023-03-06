part of 'activity_cubit.dart';

@immutable
abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final Activity activityDescription;

  ActivityLoaded(
    this.activityDescription,
  );
}

class ActivityListLoaded extends ActivityState {
  final List<Activity> activities;

  ActivityListLoaded(
    this.activities,
  );
}

class ActivityError extends ActivityState {
  final String errorDescription;

  ActivityError(
    this.errorDescription,
  );
}
