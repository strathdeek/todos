import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/bloc/filtered_todo_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/constants/enums.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/todo_filter.dart';
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
                BlocProvider(
                  create: (context) {
                    return FilteredTodoBloc(todoBloc: context.read<TodoBloc>())
                      ..add(FilteredTodoFilterChanged(TodoFilter(
                          filterByCategory: true,
                          filterByDate: true,
                          filterByDone: false,
                          category: category,
                          dateFilter: DateFilterType.onDate,
                          date: DateTime.now())));
                  },
                  child: BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: Checkbox(
                                value: state.todos[index].done,
                                onChanged: (done) {
                                  if (done == null) {
                                    return;
                                  }
                                  context.read<TodoBloc>().add(TodoDoneToggled(
                                      state.todos[index], done));
                                }),
                            title: Text(
                              state.todos[index].title,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => context
                                  .read<TodoBloc>()
                                  .add(TodoDeleted(state.todos[index])),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
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
