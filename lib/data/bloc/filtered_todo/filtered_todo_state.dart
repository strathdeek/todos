part of 'filtered_todo_bloc.dart';

abstract class FilteredTodoState extends Equatable {
  final TodoFilter filter;
  final List<Todo> todos;

  const FilteredTodoState({
    required this.filter,
    required this.todos,
  });

  @override
  List<Object> get props => [filter, todos];
}

class FilteredTodoLoadInProgress extends FilteredTodoState {
  FilteredTodoLoadInProgress()
      : super(
          todos: [],
          filter: TodoFilter(
              filterByDate: false,
              filterByCategory: false,
              filterByDone: false),
        );
}

class FilteredTodoLoadSuccess extends FilteredTodoState {
  FilteredTodoLoadSuccess(List<Todo> todos, TodoFilter filter)
      : super(
          filter: filter,
          todos: todos,
        );
}

class FilteredTodoLoadFail extends FilteredTodoState {
  final String error;
  FilteredTodoLoadFail(this.error)
      : super(
          todos: [],
          filter: TodoFilter(
              filterByDate: false,
              filterByCategory: false,
              filterByDone: false),
        );
}
