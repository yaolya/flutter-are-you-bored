part of 'activity_cubit.dart';

@immutable
abstract class ActivityState extends Equatable {}

class ActivityInitial extends ActivityState {
  final String initState;
  ActivityInitial({
    required this.initState,
  });

  @override
  List<Object?> get props => [this.initState];
}

class ActivityLoaded extends ActivityState {
  final Activity activityDescription;

  ActivityLoaded(
    this.activityDescription,
  );

  @override
  List<Object?> get props => [this.activityDescription];
}

class ActivityListLoaded extends ActivityState {
  final List<Activity> activities;

  ActivityListLoaded(
    this.activities,
  );

  @override
  List<Object?> get props => [activities];
}

class CurrentActivity extends ActivityState {
  final Activity? currentActivity;

  CurrentActivity(
    this.currentActivity,
  );

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ActivityError extends ActivityState {
  final String errorDescription;

  ActivityError(
    this.errorDescription,
  );

  @override
  List<Object?> get props => [this.errorDescription];
}
