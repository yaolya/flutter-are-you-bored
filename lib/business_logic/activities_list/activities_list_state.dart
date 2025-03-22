part of 'activities_list_cubit.dart';

abstract class ActivitiesListState extends Equatable {
  final List<ActivityModel>? activities;
  const ActivitiesListState({required this.activities});

  @override
  List<Object?> get props => [activities];
}

class ActivitiesListInitial extends ActivitiesListState {
  const ActivitiesListInitial() : super(activities: null);
}

class ActivitiesListLoadingInProgress extends ActivitiesListState {
  const ActivitiesListLoadingInProgress({required super.activities});
}

class ActivitiesListLoadingSuccess extends ActivitiesListState {
  const ActivitiesListLoadingSuccess({required super.activities});
}

class ActivitiesListLoadingFailure extends ActivitiesListState {
  final Exception exception;
  const ActivitiesListLoadingFailure({
    required super.activities,
    required this.exception,
  });

  @override
  List<Object?> get props => [activities, exception];
}

class ActivitiesListDeleteInProgress extends ActivitiesListState {
  const ActivitiesListDeleteInProgress({required super.activities});
}

class ActivitiesListDeleteFailure extends ActivitiesListState {
  final Exception exception;
  const ActivitiesListDeleteFailure({
    required super.activities,
    required this.exception,
  });

  @override
  List<Object?> get props => [activities, exception];
}
