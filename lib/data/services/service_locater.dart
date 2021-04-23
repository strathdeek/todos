import 'package:get_it/get_it.dart';

import 'authentication/index.dart';

final getIt = GetIt.instance;

void setupServiceLocater() {
  getIt.registerSingleton<AuthenticationService>(
    FirebaseAuthenticationService(),
    dispose: (service) => service.dispose(),
  );
}
