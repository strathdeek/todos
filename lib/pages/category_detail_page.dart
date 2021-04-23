import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/bloc/filtered_todo_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/data/models/todo_filter.dart';
import 'package:todos/widgets/category_icon.dart';
import 'package:todos/widgets/category_sumary.dart';
import 'package:todos/widgets/todo_list.dart';

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
            padding: EdgeInsets.only(top: 35, left: 40, right: 40),
            alignment: Alignment.center,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: CategoryIcon(category: category)),
                CategorySummary(category: category),
                Expanded(
                    child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Today',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    BlocProvider(
                      create: (context) {
                        return FilteredTodoBloc(
                            todoBloc: context.read<TodoBloc>())
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
                          return Column(
                            children: state.todos
                                .map((todo) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Checkbox(
                                          value: todo.done,
                                          onChanged: (done) {
                                            if (done == null) {
                                              return;
                                            }
                                            context.read<TodoBloc>().add(
                                                TodoDoneToggled(todo, done));
                                          }),
                                      title: Text(
                                        todo.title,
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => context
                                            .read<TodoBloc>()
                                            .add(TodoDeleted(todo)),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Tomorrow',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    BlocProvider(
                      create: (context) {
                        return FilteredTodoBloc(
                            todoBloc: context.read<TodoBloc>())
                          ..add(FilteredTodoFilterChanged(TodoFilter(
                              filterByCategory: true,
                              filterByDate: true,
                              filterByDone: false,
                              category: category,
                              dateFilter: DateFilterType.onDate,
                              date: DateTime.now().add(Duration(days: 1)))));
                      },
                      child: BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
                        builder: (context, state) {
                          return Column(
                            children: state.todos
                                .map((todo) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Checkbox(
                                          value: todo.done,
                                          onChanged: (done) {
                                            if (done == null) {
                                              return;
                                            }
                                            context.read<TodoBloc>().add(
                                                TodoDoneToggled(todo, done));
                                          }),
                                      title: Text(
                                        todo.title,
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => context
                                            .read<TodoBloc>()
                                            .add(TodoDeleted(todo)),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Later',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    BlocProvider(
                      create: (context) {
                        return FilteredTodoBloc(
                            todoBloc: context.read<TodoBloc>())
                          ..add(FilteredTodoFilterChanged(TodoFilter(
                              filterByCategory: true,
                              filterByDate: true,
                              filterByDone: false,
                              category: category,
                              dateFilter: DateFilterType.afterDate,
                              date: DateTime.now().add(Duration(days: 1)))));
                      },
                      child: BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
                        builder: (context, state) {
                          return Column(
                            children: state.todos
                                .map((todo) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Checkbox(
                                          value: todo.done,
                                          onChanged: (done) {
                                            if (done == null) {
                                              return;
                                            }
                                            context.read<TodoBloc>().add(
                                                TodoDoneToggled(todo, done));
                                          }),
                                      title: Text(
                                        todo.title,
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => context
                                            .read<TodoBloc>()
                                            .add(TodoDeleted(todo)),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ],
                )),
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
