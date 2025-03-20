import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:are_you_bored/data/repositories/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/error_details.dart';
import '../../data/repositories/i_activity_repository.dart';
import '../../../data/models/activity.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  late final IActivityRepository _repository;
  late StreamSubscription repositorySubscription;

  ActivityCubit({required IActivityRepository activityRepository})
      : _repository = activityRepository,
        super(ActivityInitial()) {
    repositorySubscription = _repository.eventsStream.listen((event) {
      if (event is ActivityRepositoryCurrentActivityDeletedEvent) {
        _onCurrentActivityDeleted();
      }
    });
  }

  @override
  Future<void> close() async {
    repositorySubscription.cancel();
    super.close();
  }

  void _onCurrentActivityDeleted() {
    emit(ActivityLoadingSuccess(activity: state.activity?.copyWith(false)));
  }

  Future<void> getNextButtonTapped() async {
    try {
      emit(ActivityLoadingInProgress(activity: state.activity));
      final activity = await _repository.getRandomActivity();
      final isSaved = await _repository.isSaved(activity);
      emit(ActivityLoadingSuccess(activity: activity.copyWith(isSaved)));
    } catch (e) {
      emit(ActivityLoadingFailure(
        activity: null,
        exception: const MessageException('Failed to perform operation'),
      ));
    }
  }

  void getCurrentActivity() {
    final activity = _repository.currentActivity;
    if (activity != null) {
      emit(ActivityLoadingSuccess(activity: activity));
    } else {
      emit(ActivityInitial());
    }
  }

  void saveButtonTapped(Activity? activity) {
    if (activity == null) return;
    try {
      _repository.addActivity(activity);
      emit(ActivityLoadingSuccess(activity: activity.copyWith(true)));
    } catch (e) {
      emit(ActivitySaveFailure(
        activity: activity,
        exception: const MessageException('Failed to save the activity'),
      ));
    }
  }

  void notifySaveActivityFailureProcessed(Activity? activity) {
    emit(ActivityLoadingSuccess(activity: activity));
  }
}
