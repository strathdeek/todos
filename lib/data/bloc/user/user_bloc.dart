import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/bloc/authentication/authentication_bloc.dart';
import 'package:todos/data/exceptions/index.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;
  late StreamSubscription authenticationSubscription;
  UserBloc(this.authenticationBloc, this.userRepository)
      : super(authenticationBloc.state is AuthenticationAuthenticated
            ? UserLoadInProgress()
            : UserNotSignedIn()) {
    authenticationSubscription = authenticationBloc.stream
        .listen(_synchronizeUserWithAuthenticationState);
    _synchronizeUserWithAuthenticationState(authenticationBloc.state);
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserSignedIn) {
      yield UserLoadSuccess(event.user);
    } else if (event is UserSignedOut) {
      yield UserNotSignedIn();
    } else if (event is UserNotFoundInRepository) {
      yield UserLoadFail(event.error);
    } else if (event is UserCreated) {
      await userRepository.addUser(event.user);
      yield UserLoadSuccess(event.user);
    }
  }

  void _synchronizeUserWithAuthenticationState(
      AuthenticationState event) async {
    if (event is AuthenticationAuthenticated) {
      try {
        var user = await userRepository.getUser(
            (authenticationBloc.state as AuthenticationAuthenticated).userId);
        add(UserSignedIn(user));
      } on UserRepositoryException catch (e) {
        add(UserNotFoundInRepository(e.message));
      }
    } else {
      add(UserSignedOut());
    }

    @override
    Future<void> close() {
      authenticationSubscription.cancel();
      return super.close();
    }
  }
}
