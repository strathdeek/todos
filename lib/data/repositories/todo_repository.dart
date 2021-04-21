import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/providers/todo_provider.dart';
import 'package:todos/utils/extensions.dart';

class TodoRepository {
  final TodoProvider _todoProvider;

  TodoRepository(this._todoProvider);

  Future<List<Todo>> getAllTodos() async {
    return await _todoProvider.getTodos();
  }

  Future<List<Todo>> getAllTodosForCategory(Category category) async {
    var todos = await _todoProvider.getTodos();
    return todos.where((element) => (element.category) == category).toList();
  }

  Future<List<Todo>> getAllTodosDueOn(DateTime date) async {
    var todos = await _todoProvider.getTodos();
    return todos.where((element) => element.dueDate.isSameDate(date)).toList();
  }

  Future<List<Todo>> getAllMissedTodos() async {
    var todos = await _todoProvider.getTodos();
    return todos
        .where((element) => element.dueDate.isBefore(DateTime.now()))
        .where((element) => !(element.done))
        .toList();
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
