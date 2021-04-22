import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todos/data/models/category.dart';

import 'package:uuid/uuid.dart';
part 'todo.g.dart';

@HiveType(typeId: 2)
class Todo extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime dueDate;
  @HiveField(2)
  final Category category;
  @HiveField(3)
  final bool done;
  @HiveField(4)
  final String id;

  Todo(
      {required this.title,
      required this.dueDate,
      required this.category,
      required this.done,
      String? id})
      : id = id ?? Uuid().v4();

  Todo copyWith(
      {String? title, DateTime? dueDate, Category? category, bool? done}) {
    return Todo(
        title: title ?? this.title,
        category: category ?? this.category,
        dueDate: dueDate ?? this.dueDate,
        id: id,
        done: done ?? this.done);
  }

  @override
  List<Object?> get props => [title, dueDate, category, done, id];
}
