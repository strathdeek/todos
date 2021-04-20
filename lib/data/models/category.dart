import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Category extends HiveObject {
  final String name;
  final Color color;
  final IconData iconData;
  final double progress = Random().nextDouble();

  Category({required this.name, required this.color, required this.iconData});
}
