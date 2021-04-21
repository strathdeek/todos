part of 'filtered_todo_bloc.dart';

abstract class FilteredTodoState extends Equatable {
  final TodoFilter filter;
  final DateTime date;
  final List<Todo> todos;
  final Category category;

  const FilteredTodoState({
    required this.filter,
    required this.date,
    required this.todos,
    required this.category,
  });

  @override
  List<Object> get props => [filter, date, todos];
}

class FilteredTodoLoadInProgress extends FilteredTodoState {
  FilteredTodoLoadInProgress()
      : super(
            todos: [],
            date: DateTime.now(),
            filter: TodoFilter.all,
            category: Category.home);
}

class FilteredTodoLoadSuccess extends FilteredTodoState {
  FilteredTodoLoadSuccess(
      List<Todo> todos, TodoFilter filter, DateTime date, Category category)
      : super(filter: filter, date: date, todos: todos, category: category);
}

class FilteredTodoLoadFail extends FilteredTodoState {
  final String error;
  FilteredTodoLoadFail(this.error)
      : super(
            todos: [],
            date: DateTime.now(),
            filter: TodoFilter.all,
            category: Category.home);
}
