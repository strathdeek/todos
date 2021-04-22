import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/bloc/filtered_todo_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/constants/enums.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/todo_filter.dart';

class CategoryProgressIndicator extends StatelessWidget {
  final Color color;
  final Category category;
  final int totalTodos;

  const CategoryProgressIndicator(
      {Key? key,
      required this.color,
      required this.category,
      required this.totalTodos})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilteredTodoBloc(todoBloc: context.read<TodoBloc>())
        ..add(FilteredTodoFilterChanged(TodoFilter(
            filterByCategory: true,
            filterByDate: true,
            filterByDone: true,
            category: category,
            date: DateTime.now(),
            dateFilter: DateFilterType.onDate))),
      child: Container(
        child: BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
          builder: (context, state) {
            var progress = totalTodos > 0 ? state.todos.length / totalTodos : 0;
            return Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress.toDouble(),
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: TextStyle(color: Colors.grey.shade600),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
