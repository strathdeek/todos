import 'package:todos/data/models/index.dart';
import 'package:todos/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider userProvider;

  UserRepository(this.userProvider);

  Future<User> getUser(String id) {
    return userProvider.get(id);
  }

  Future<void> addUser(User user) async {
    await userProvider.add(user);
  }

  Future<void> removeUser(User user) async {
    await userProvider.delete(user);
  }

  Future<void> updateUser(User user) async {
    await userProvider.update(user);
  }
}
