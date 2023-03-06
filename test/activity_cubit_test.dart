import 'package:first_app/data/data_providers/activity_api.dart';
import 'package:first_app/data/repositories/activity_repository.dart';
import 'package:test/test.dart';
import 'package:first_app/business_logic/cubits/activity_cubit.dart';

void main() {
  group('ActivityCubit', () {
    late ActivityCubit activityCubit;
    final ActivityAPI api = ActivityAPI();
    final ActivityRepository repository = ActivityRepository(api: api);

    setUp(() {
      activityCubit = ActivityCubit(activityRepository: repository);
    });

    tearDown(() {
      activityCubit.close();
    });

    // test(
    //     'the initial stste for the ActivityCubit is ActivityState: Press button to get an activity',
    //     () {
    //   expect(activityCubit.state,
    //       ActivityInitial(activityDescription: 'Press button to get an activity'));
    // });
  });
}
