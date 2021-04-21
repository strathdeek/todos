import 'package:hive/hive.dart';
import 'package:todos/data/constants/constants.dart';
import 'package:todos/data/models/todo.dart';

class TodoProvider {
  final Box<Todo> _todoBox = Hive.box(HiveTodoBoxKey);

  Future<void> addTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await todo.save();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todo.delete();
  }

  Future<List<Todo>> getTodos() async {
    return _todoBox.values.toList();
  }
}
