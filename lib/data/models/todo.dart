import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todos/data/models/category.dart';

import 'package:uuid/uuid.dart';
part 'todo.g.dart';

@HiveType(typeId: 2)
class Todo extends HiveObject implements Equatable {
  @HiveField(0)
  String title;
  @HiveField(1)
  DateTime dueDate;
  @HiveField(2)
  Category category;
  @HiveField(3)
  bool done;
  @HiveField(4)
  final String id;

  Todo(
      {required this.title,
      required this.dueDate,
      required this.category,
      required this.done})
      : id = Uuid().v4();

  @override
  List<Object?> get props => [title, dueDate, category, done];

  @override
  bool? get stringify => false;
}
