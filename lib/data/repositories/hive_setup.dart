import 'package:hive/hive.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initializeHiveDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>(HiveUserBoxKey);
}
