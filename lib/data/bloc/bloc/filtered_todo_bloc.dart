import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/constants/enums.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/utils/extensions.dart';

part 'filtered_todo_event.dart';
part 'filtered_todo_state.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {
  final TodoBloc todoBloc;
  late StreamSubscription todoSubscription;

  FilteredTodoBloc({required this.todoBloc})
      : super(todoBloc.state is TodoLoadSuccess
            ? FilteredTodoLoadSuccess(todoBloc.state.todos, TodoFilter.all,
                DateTime.now(), Category.home)
            : FilteredTodoLoadInProgress()) {
    todoSubscription = todoBloc.stream.listen(monitorTodoState);
  }

  void monitorTodoState(TodoState state) {
    if (state is TodoLoadSuccess) {
      add(FilteredTodoTodosChanged(state.todos));
    }
  }

  @override
  Stream<FilteredTodoState> mapEventToState(
    FilteredTodoEvent event,
  ) async* {
    if (event is FilteredTodoTodosChanged) {
      yield* _mapFilteredTodoTodosChangedToState(event);
    } else if (event is FilteredTodoFilterChanged) {
      yield* _mapFilteredTodoFilterChangedToState(event);
    } else if (event is FilteredTodoDateChanged) {
      yield* _mapFilteredTodoDateChangedToState(event);
    } else if (event is FilteredTodoCategoryChanged) {
      yield* _mapFilteredTodoCategoryChangedToState(event);
    }
  }

  Stream<FilteredTodoState> _mapFilteredTodoTodosChangedToState(
      FilteredTodoTodosChanged event) async* {
    yield FilteredTodoLoadSuccess(
        _filterTodos(
            todos: event.todos,
            filter: state.filter,
            date: state.date,
            category: state.category),
        state.filter,
        state.date,
        state.category);
  }

  Stream<FilteredTodoState> _mapFilteredTodoFilterChangedToState(
      FilteredTodoFilterChanged event) async* {
    yield FilteredTodoLoadSuccess(
        _filterTodos(
            todos: state.todos,
            filter: event.filter,
            date: state.date,
            category: state.category),
        event.filter,
        state.date,
        state.category);
  }

  Stream<FilteredTodoState> _mapFilteredTodoDateChangedToState(
      FilteredTodoDateChanged event) async* {
    yield FilteredTodoLoadSuccess(
        _filterTodos(
            todos: state.todos,
            filter: state.filter,
            date: event.date,
            category: state.category),
        state.filter,
        event.date,
        state.category);
  }

  Stream<FilteredTodoState> _mapFilteredTodoCategoryChangedToState(
      FilteredTodoCategoryChanged event) async* {
    yield FilteredTodoLoadSuccess(
        _filterTodos(
            todos: state.todos,
            filter: state.filter,
            date: state.date,
            category: event.category),
        state.filter,
        state.date,
        event.category);
  }

  List<Todo> _filterTodos(
      {required List<Todo> todos,
      required TodoFilter filter,
      required DateTime date,
      required Category category}) {
    switch (filter) {
      case TodoFilter.all:
        return todos;
      case TodoFilter.active:
        return todos.where((element) => !element.done).toList();
      case TodoFilter.completed:
        return todos.where((element) => element.done).toList();
      case TodoFilter.onDate:
        return todos
            .where((element) => element.dueDate.isSameDate(date))
            .toList();
      case TodoFilter.beforeDate:
        return todos
            .where((element) => element.dueDate.isBefore(date))
            .toList();
      case TodoFilter.afterDate:
        return todos.where((element) => element.dueDate.isAfter(date)).toList();
      case TodoFilter.category:
        return todos.where((element) => element.category == category).toList();
      case TodoFilter.completedCategory:
        return todos
            .where((element) => element.category == category)
            .where((element) => element.done)
            .toList();

      default:
        return todos;
    }
  }

  @override
  Future<void> close() {
    todoSubscription.cancel();
    return super.close();
  }
}
