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

class FilteredTodoDateChanged extends FilteredTodoEvent {
  final DateTime date;

  FilteredTodoDateChanged(this.date);
}

class FilteredTodoTodosChanged extends FilteredTodoEvent {
  final List<Todo> todos;

  FilteredTodoTodosChanged(this.todos);
}

class FilteredTodoCategoryChanged extends FilteredTodoEvent {
  final Category category;

  FilteredTodoCategoryChanged(this.category);
}
