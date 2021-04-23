import 'package:hive/hive.dart';
import 'package:todos/data/constants/constants.dart';
import 'package:todos/data/exceptions/index.dart';
import 'package:todos/data/models/index.dart';

class UserProvider {
  final Box<User> _todoBox = Hive.box(HiveUserBoxKey);

  Future<void> add(User user) async {
    await _todoBox.put(user.id, user);
  }

  Future<void> update(User user) async {
    await _todoBox.put(user.id, user);
  }

  Future<void> delete(User user) async {
    await _todoBox.delete(user.id);
  }

  Future<User> get(String id) async {
    var user = _todoBox.get(id);
    if (user != null) {
      return user;
    } else {
      throw UserRepositoryException('No user matching id: $id');
    }
  }
}
