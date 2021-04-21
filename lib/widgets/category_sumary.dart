import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/bloc/filtered_todo_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/constants/enums.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/widgets/category_progress_indicator.dart';
import 'package:todos/utils/extensions.dart';

class CategorySummary extends StatelessWidget {
  final Category category;

  const CategorySummary({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('category summary loading: $category');
    return Container(
      child: BlocProvider(
        create: (context) =>
            FilteredTodoBloc(todoBloc: context.read<TodoBloc>())
              ..add(FilteredTodoFilterChanged(TodoFilter.category))
              ..add(FilteredTodoCategoryChanged(category)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
              builder: (context, state) {
                return Text(
                  '${state.todos.length} Tasks',
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
                );
              },
            ),
            SizedBox(height: 10),
            Text(category.getName().capitalize(),
                style: TextStyle(fontSize: 35, color: Colors.grey.shade700)),
            SizedBox(height: 15),
            BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
              builder: (context, state) {
                return CategoryProgressIndicator(
                    color: category.getColor(),
                    category: category,
                    totalTodos: state.todos.length);
              },
            )
          ],
        ),
      ),
    );
  }
}
