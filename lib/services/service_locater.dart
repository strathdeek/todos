import 'package:get_it/get_it.dart';
import 'package:todos/services/authentication/index.dart';

final getIt = GetIt.instance;

void setupServiceLocater() {
  getIt.registerSingleton<AuthenticationService>(
      FirebaseAuthenticationService());
}
