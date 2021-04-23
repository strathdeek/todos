import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/providers/todo_provider.dart';

class TodoRepository {
  final TodoProvider _todoProvider;

  TodoRepository(this._todoProvider);

  Future<List<Todo>> getAllTodos() async {
    return await _todoProvider.getTodos();
  }

  Future<Todo> addTodo(
      {required String title,
      required DateTime dueDate,
      required Category category}) async {
    var todo =
        Todo(title: title, dueDate: dueDate, category: category, done: false);
    await _todoProvider.addTodo(todo);
    return todo;
  }

  Future<void> deleteTodo(Todo todo) async {
    await _todoProvider.deleteTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoProvider.updateTodo(todo);
  }
}
