import 'package:equatable/equatable.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:first_app/data/data_providers/activity_api.dart';
import 'package:first_app/data/repositories/mock_activity_repository.dart';
import 'package:first_app/business_logic/cubits/activity_cubit.dart';

void main() {
  group('ActivityCubit', () {
    late ActivityCubit activityCubit;
    MockActivityRepository mockRepository;

    setUp(() {
      mockRepository = MockActivityRepository();
      activityCubit = ActivityCubit(activityRepository: mockRepository);
    });

    test(
        ': emits ActivityInitial state for'
        'ActivityCubit', () {
      expect(activityCubit.state,
          ActivityInitial(initState: "Tap a button to get an activity"));
    });

    blocTest<ActivityCubit, ActivityState>(
      ': emits ActivityLoaded state for '
      'successful activity load',
      build: () => activityCubit,
      act: (cubit) => cubit.getNextButtonTapped(),
      expect: () => [
        ActivityLoaded(mockActivity),
      ],
    );

    blocTest<ActivityCubit, ActivityState>(
      ': emits ActivityListLoaded state for '
      'successful activities load',
      build: () => activityCubit,
      act: (cubit) => cubit.getActivities(),
      expect: () => [
        ActivityListLoaded(activitiesList),
      ],
    );

    tearDown(() {
      activityCubit.close();
    });
  });
}
