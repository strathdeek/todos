import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todos/utils/extensions.dart';

part 'category.g.dart';

@HiveType(typeId: 3)
enum Category {
  @HiveField(0)
  work,
  @HiveField(1)
  home,
  @HiveField(2)
  personal
}

extension DataTransformations on Category {
  String getName() {
    return toString().split('.').last.capitalize();
  }

  Color getColor() {
    switch (this) {
      case Category.personal:
        return Color.fromARGB(255, 231, 130, 109);
      case Category.work:
        return Color.fromARGB(255, 99, 137, 223);
      case Category.home:
        return Color.fromARGB(255, 112, 194, 173);
      default:
        return Color.fromARGB(255, 231, 130, 109);
    }
  }

  IconData getIcon() {
    switch (this) {
      case Category.personal:
        return Icons.person;
      case Category.work:
        return Icons.work;
      case Category.home:
        return Icons.home;
      default:
        return Icons.person;
    }
  }
}
