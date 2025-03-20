import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/error_details.dart';
import '../../data/repositories/i_activity_repository.dart';
import '../../../data/models/activity.dart';

part 'activities_list_state.dart';

class ActivitiesListCubit extends Cubit<ActivitiesListState> {
  late final IActivityRepository _repository;

  ActivitiesListCubit({required IActivityRepository activityRepository})
      : _repository = activityRepository,
        super(ActivitiesListInitial());

  void getActivities() async {
    try {
      emit(ActivitiesListLoadingInProgress(activities: state.activities));
      final activities = await _repository.getActivitiesList();
      emit(ActivitiesListLoadingSuccess(activities: activities));
    } catch (e) {
      emit(ActivitiesListLoadingFailure(
        activities: state.activities,
        exception: const MessageException('Failed to perform operation'),
      ));
    }
  }

  void deleteActivity(Activity activity) async {
    try {
      emit(ActivitiesListDeleteInProgress(activities: state.activities));
      _repository.deleteActivity(activity);
      final newActivitiesList = state.activities;
      newActivitiesList?.removeWhere((e) => e.id == activity.id);
      emit(ActivitiesListLoadingSuccess(activities: newActivitiesList));
    } catch (e) {
      emit(ActivitiesListDeleteFailure(
        activities: state.activities,
        exception: const MessageException('Failed to delete activity'),
      ));
    }
  }

  void notifyDeleteActivityFailureProcessed() {
    emit(ActivitiesListLoadingSuccess(activities: state.activities));
  }
}
