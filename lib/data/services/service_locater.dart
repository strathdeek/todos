import 'package:get_it/get_it.dart';
import 'package:todos/data/repositories/user/hive_user_repository.dart';
import 'package:todos/data/repositories/user/user_repository.dart';

import 'authentication/index.dart';

final getIt = GetIt.instance;

void setupServiceLocater() {
  getIt.registerSingleton<AuthenticationService>(
    FirebaseAuthenticationService(),
    dispose: (service) => service.dispose(),
  );
  getIt.registerSingleton<UserRepository>(HiveUserRepository());
}
