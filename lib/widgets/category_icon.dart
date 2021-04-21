import 'package:flutter/material.dart';
import 'package:todos/data/models/category.dart';

class CategoryIcon extends StatelessWidget {
  final Category category;
  final double size;
  const CategoryIcon({Key? key, required this.category, this.size = 30})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
          onPressed: () => print('tapped more'),
          elevation: 0,
          fillColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
          shape: CircleBorder(side: BorderSide(color: Colors.grey.shade300)),
          child: Icon(
            category.getIcon(),
            color: category.getColor(),
            size: size,
          )),
    );
  }
}
