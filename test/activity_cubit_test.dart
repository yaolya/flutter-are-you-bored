import 'package:are_you_bored/business_logic/activity/activity_cubit.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:are_you_bored/data/repositories/activity_repository_mock.dart';

void main() {
  group('ActivityCubit', () {
    late ActivityCubit activityCubit;
    ActivityRepositoryMock mockRepository;

    setUp(() {
      mockRepository = ActivityRepositoryMock();
      activityCubit = ActivityCubit(activityRepository: mockRepository);
    });

    test(
        ': emits ActivityInitial for '
        'initial state', () {
      expect(activityCubit.state, ActivityInitial());
    });

    blocTest<ActivityCubit, ActivityState>(
      ': emits ActivityInitial state for '
      'getting current activity',
      build: () => activityCubit,
      act: (cubit) => cubit.getCurrentActivity(),
      expect: () => [ActivityInitial()],
    );

    blocTest<ActivityCubit, ActivityState>(
      ': emits ActivityLoadingSuccess state for '
      'successful activity loading',
      build: () => activityCubit,
      act: (cubit) => cubit.getNextButtonTapped(),
      expect: () => [
        ActivityLoadingInProgress(activity: null),
        ActivityLoadingSuccess(activity: mockActivity),
      ],
    );

    tearDown(() {
      activityCubit.close();
    });
  });
}
