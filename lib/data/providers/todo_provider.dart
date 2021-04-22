import 'package:hive/hive.dart';
import 'package:todos/data/constants/constants.dart';
import 'package:todos/data/models/todo.dart';

class TodoProvider {
  final Box<Todo> _todoBox = Hive.box(HiveTodoBoxKey);

  Future<void> addTodo(Todo todo) async {
    print('writing todo with key: ${todo.id}');
    await _todoBox.put(todo.id, todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
  }

  Future<void> deleteTodo(Todo todo) async {
    print(
        'deleting todo with key: ${todo.id} - key exists: ${_todoBox.containsKey(todo.id)}');
    await _todoBox.delete(todo.id);
  }

  Future<List<Todo>> getTodos() async {
    return _todoBox.values.toList();
  }
}
