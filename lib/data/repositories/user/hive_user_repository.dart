import 'package:hive/hive.dart';
import 'package:todos/data/exceptions/index.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/repositories/user/user_repository.dart';
import 'package:todos/data/constants/constants.dart';

class HiveUserRepository extends UserRepository {
  final Box<User> _userBox = Hive.box(HiveUserBoxKey);

  @override
  Future<void> addUser(User user) async {
    await _userBox.put(user.id, user);
  }

  @override
  Future<void> deleteUser(User user) async {
    await user.delete();
  }

  @override
  Future<User> getUser(String id) async {
    var user = _userBox.get(id);
    if (user == null) {
      throw UserRepositoryException('Couldnt find user with id: $id');
    }
    return user;
  }

  @override
  Future<void> updateUser(User user) async {
    await user.save();
  }
}
