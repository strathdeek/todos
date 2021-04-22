part of 'filtered_todo_bloc.dart';

abstract class FilteredTodoEvent extends Equatable {
  const FilteredTodoEvent();

  @override
  List<Object> get props => [];
}

class FilteredTodoFilterChanged extends FilteredTodoEvent {
  final TodoFilter filter;

  FilteredTodoFilterChanged(this.filter);
}

class FilteredTodoTodosChanged extends FilteredTodoEvent {
  final List<Todo> todos;

  FilteredTodoTodosChanged(this.todos);
}
