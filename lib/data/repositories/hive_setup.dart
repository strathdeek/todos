import 'package:hive/hive.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initializeHiveDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<User>(HiveUserBoxKey);
  await Hive.openBox<Todo>(HiveTodoBoxKey);
}
