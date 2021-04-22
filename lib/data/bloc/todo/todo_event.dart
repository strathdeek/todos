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
  final String? title;
  final DateTime? dueDate;
  final bool? done;
  final Category? category;

  TodoUpdated(this.todo, {this.title, this.dueDate, this.done, this.category});
}

class TodoLoadedSuccess extends TodoEvent {}

class TodoDoneToggled extends TodoEvent {
  final Todo todo;
  final bool done;
  TodoDoneToggled(this.todo, this.done);
}
