import 'package:get_it/get_it.dart';
import 'package:ixam/services/user_service.dart';

final locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton<UserService>(() => UserService());
}
