import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/models/todo_filter.dart';

part 'filtered_todo_event.dart';
part 'filtered_todo_state.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {
  final TodoBloc todoBloc;
  late StreamSubscription todoSubscription;

  FilteredTodoBloc({required this.todoBloc})
      : super(todoBloc.state is TodoLoadSuccess
            ? FilteredTodoLoadSuccess(
                todoBloc.state.todos,
                TodoFilter(
                    filterByDate: false,
                    filterByCategory: false,
                    filterByDone: false),
              )
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
    }
  }

  Stream<FilteredTodoState> _mapFilteredTodoTodosChangedToState(
      FilteredTodoTodosChanged event) async* {
    yield FilteredTodoLoadSuccess(
      _filterTodos(
        todos: event.todos,
        filter: state.filter,
      ),
      state.filter,
    );
  }

  Stream<FilteredTodoState> _mapFilteredTodoFilterChangedToState(
      FilteredTodoFilterChanged event) async* {
    yield FilteredTodoLoadSuccess(
      _filterTodos(
        todos: todoBloc.state.todos,
        filter: event.filter,
      ),
      event.filter,
    );
  }

  List<Todo> _filterTodos({
    required List<Todo> todos,
    required TodoFilter filter,
  }) {
    return filter.filter(todos);
  }

  @override
  Future<void> close() {
    todoSubscription.cancel();
    return super.close();
  }
}
