import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:todos/data/constants/enums.dart';

class Todo extends Equatable {
  final String title;
  final DateTime dueDate;
  final Category category;
  final bool done;
  Todo({
    required this.title,
    required this.dueDate,
    required this.category,
    required this.done,
  });

  Todo copyWith({
    String? title,
    DateTime? dueDate,
    Category? category,
    bool? done,
  }) {
    return Todo(
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'category': category.toMap(),
      'done': done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      category:
          Category.values.firstWhere((cat) => cat.toMap() == map['category']),
      done: map['done'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, dueDate, category, done];
}
