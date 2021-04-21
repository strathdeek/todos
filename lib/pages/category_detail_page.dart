import 'package:flutter/material.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/widgets/category_icon.dart';
import 'package:todos/widgets/category_sumary.dart';

class CategoryDetailPage extends StatelessWidget {
  final Category category;
  CategoryDetailPage(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        body: Stack(children: [
          Container(
            padding: EdgeInsets.only(top: 35, left: 40),
            alignment: Alignment.center,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: CategoryIcon(category: category)),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: CategorySummary(category: category),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 40, bottom: 80),
                  child: FloatingActionButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/addtodo', arguments: category),
                    backgroundColor: category.getColor(),
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                  )))
        ]),
      ),
    );
  }
}
