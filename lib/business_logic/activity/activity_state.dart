part of 'activity_cubit.dart';

@immutable
abstract class ActivityState extends Equatable {
  final ActivityModel? activity;
  const ActivityState({required this.activity});
  @override
  List<Object?> get props => [activity];
}

class ActivityInitial extends ActivityState {
  const ActivityInitial() : super(activity: null);
}

class ActivityLoadingInProgress extends ActivityState {
  const ActivityLoadingInProgress({required super.activity});
}

class ActivityLoadingSuccess extends ActivityState {
  const ActivityLoadingSuccess({required super.activity});
}

class ActivityLoadingFailure extends ActivityState {
  final Exception exception;
  const ActivityLoadingFailure({
    required this.exception,
    required super.activity,
  });

  @override
  List<Object?> get props => [activity, exception];
}

class ActivitySaveFailure extends ActivityState {
  final Exception exception;

  const ActivitySaveFailure({
    required this.exception,
    required super.activity,
  });

  @override
  List<Object?> get props => [activity, exception];
}
