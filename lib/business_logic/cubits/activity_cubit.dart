import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../data/repositories/i_activity_repository.dart';
import '../../../data/models/activity.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  late final IActivityRepository _repository;

  ActivityCubit({required IActivityRepository activityRepository})
      : _repository = activityRepository,
        super(ActivityInitial(initState: "Tap a button to get an activity"));

  void getNextButtonTapped() async {
    try {
      final activity = await _repository.getRandomActivity();
      emit(ActivityLoaded(activity));
    } catch (e) {
      emit(ActivityError("Couldn't get an activity. Is the device online?"));
    }
  }

  void getActivities() {
    final activities = _repository.fetchActivities();
    emit(ActivityListLoaded(activities));
  }

  void getCurrentActivity() {
    final activity = _repository.getCurrentActivity();
    if (activity != null) {
      emit(CurrentActivity(activity));
    } else {
      emit(ActivityInitial(initState: "Tap a button to get an activity"));
    }
  }

  void saveButtonTapped(Activity activity) {
    _repository.addActivity(activity);
  }
}
