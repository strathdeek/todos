part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserSignedIn extends UserEvent {
  final User user;

  UserSignedIn(this.user);

  @override
  List<Object> get props => [user];
}

class UserCreated extends UserEvent {
  final User user;

  UserCreated(this.user);

  @override
  List<Object> get props => [user];
}

class UserSignedOut extends UserEvent {}

class UserNotFoundInRepository extends UserEvent {
  final String error;

  UserNotFoundInRepository(this.error);

  @override
  List<Object> get props => [error];
}
