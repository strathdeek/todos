import 'package:todos/data/models/index.dart';

abstract class UserRepository {
  Future<User> getUser(String id);
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);
}
