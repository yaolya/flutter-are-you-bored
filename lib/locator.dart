import 'package:are_you_bored/data/database/drift_database.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton(() => AppDatabase());
}
