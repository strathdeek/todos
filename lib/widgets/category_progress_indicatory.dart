import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/bloc/filtered_todo_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/constants/enums.dart';

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
        ..add(FilteredTodoFilterChanged(TodoFilter.completedCategory))
        ..add(FilteredTodoCategoryChanged(category)),
      child: Container(
        child: BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
          builder: (context, state) {
            return LinearProgressIndicator(
              value: totalTodos > 0 ? state.todos.length / totalTodos : 0,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            );
          },
        ),
      ),
    );
  }
}