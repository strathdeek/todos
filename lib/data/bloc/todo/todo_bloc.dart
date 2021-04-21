import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.todoRepository}) : super(TodoLoadInProgress());

  final TodoRepository todoRepository;

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is TodoLoadedSuccess) {
      yield* _mapTodoLoadedSuccessToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoMarkedAsDone) {
      yield* _mapTodoMarkedAsDoneToState(event);
    }
  }

  Stream<TodoState> _mapTodoLoadedSuccessToState() async* {
    yield TodoLoadInProgress();
    try {
      var todos = await todoRepository.getAllTodos();
      yield TodoLoadSuccess(todos);
    } catch (e) {
      yield TodoLoadFailed(error: 'error loading todos');
    }
  }

  Stream<TodoState> _mapTodoAddedToState(TodoAdded event) async* {
    try {
      var todo = await todoRepository.addTodo(
          category: event.category, dueDate: event.dueDate, title: event.title);
      var todos = List<Todo>.from(state.todos)..add(todo);
      yield TodoLoadSuccess(todos);
    } catch (e) {
      yield TodoLoadFailed(error: 'error adding todo');
    }
  }

  Stream<TodoState> _mapTodoDeletedToState(TodoDeleted event) async* {
    try {
      await todoRepository.deleteTodo(event.todo);
      var todos = List<Todo>.from(state.todos)..remove(event.todo);
      yield TodoLoadSuccess(todos);
    } catch (e) {
      yield TodoLoadFailed(error: 'error deleting todo');
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    try {
      await todoRepository.updateTodo(event.todo);
      var todos = List<Todo>.from(state.todos)
          .map<Todo>((e) => e.id == event.todo.id ? event.todo : e)
          .toList();
      yield TodoLoadSuccess(todos);
    } catch (e) {
      yield TodoLoadFailed(error: 'error updating todo');
    }
  }

  Stream<TodoState> _mapTodoMarkedAsDoneToState(TodoMarkedAsDone event) async* {
    try {
      event.todo.done = true;
      await todoRepository.updateTodo(event.todo);
      var todos = List<Todo>.from(state.todos)
          .map<Todo>((e) => e.id == event.todo.id ? event.todo : e)
          .toList();
      yield TodoLoadSuccess(todos);
    } catch (e) {
      yield TodoLoadFailed(error: 'error marking todo as done');
    }
  }
}
