import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:first_app/data/repositories/activity_repository.dart';
import '../../../data/models/activity.dart';
import 'package:http/http.dart' as http;

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  late final ActivityRepository _repository;

  ActivityCubit({required ActivityRepository activityRepository})
      : _repository = activityRepository,
        super(ActivityInitial());

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

  void saveButtonTapped(Activity activity) {
    _repository.addActivity(activity);
  }
}
