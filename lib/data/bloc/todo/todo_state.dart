part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  final List<Todo> todos;
  const TodoState({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoLoadInProgress extends TodoState {
  TodoLoadInProgress() : super(todos: []);
}

class TodoLoadSuccess extends TodoState {
  TodoLoadSuccess(List<Todo> todos) : super(todos: todos);
}

class TodoLoadFailed extends TodoState {
  final String error;
  TodoLoadFailed({required this.error}) : super(todos: []);
  @override
  List<Object> get props => [error];
}
