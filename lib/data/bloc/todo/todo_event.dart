part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoAdded extends TodoEvent {
  final String title;
  final DateTime dueDate;
  final Category category;

  TodoAdded(
      {required this.title, required this.dueDate, required this.category});
}

class TodoDeleted extends TodoEvent {
  final Todo todo;

  TodoDeleted(this.todo);
}

class TodoUpdated extends TodoEvent {
  final Todo todo;

  TodoUpdated(this.todo);
}

class TodoLoadedSuccess extends TodoEvent {}

class TodoMarkedAsDone extends TodoEvent {
  final Todo todo;

  TodoMarkedAsDone(this.todo);
}
