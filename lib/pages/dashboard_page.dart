import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/authentication/authentication_bloc.dart';
import 'package:todos/data/bloc/bloc/filtered_todo_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/constants/enums.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/widgets/avatar.dart';
import 'package:todos/widgets/category_progress_indicatory.dart';
import 'package:todos/widgets/widgets.dart';
import 'package:todos/utils/extensions.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;

  Color _getColorForCategory(Category category) {
    switch (category) {
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

  IconData _getIconDataForCategory(Category category) {
    switch (category) {
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

  final _sections = Category.values;

  Container buildUserSummary(User user) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            image: AssetImage('assets/KS_portrait.jpeg'),
            radius: 80,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Hello, ${user.name}.',
            style: TextStyle(color: Colors.white, fontSize: 35),
          ),
          SizedBox(
            height: 10,
          ),
          BlocProvider(
            create: (context) =>
                FilteredTodoBloc(todoBloc: context.read<TodoBloc>())
                  ..add(FilteredTodoFilterChanged(TodoFilter.all)),
            child: BlocBuilder<FilteredTodoBloc, FilteredTodoState>(
              builder: (context, state) {
                return Text(
                  'Welcome!\nYou have ${state.todos.length} tasks to do today',
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade200),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (!(state is AuthenticationAuthenticated)) {
          return Scaffold(body: CircularProgressIndicator());
        }
        var user = (state).user;
        return Scaffold(
          body: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            color: _getColorForCategory(_sections[_index]),
            child: Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () => context
                                .read<AuthenticationBloc>()
                                .add(LoggedOut())),
                        Text(
                          'TODO',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: () => print('tapped search')),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 50, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildUserSummary(user),
                          SizedBox(
                            height: 50,
                          ),
                          TodaysDate(),
                        ],
                      )),
                  Expanded(
                      child: PageView.builder(
                    itemCount: _sections.length,
                    controller: PageController(viewportFraction: .8),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 15, right: 15, bottom: 30),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RawMaterialButton(
                                      onPressed: () => print('tapped more'),
                                      elevation: 0,
                                      fillColor: Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 5),
                                      shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.grey.shade300)),
                                      child: Icon(
                                        _getIconDataForCategory(_sections[i]),
                                        color:
                                            _getColorForCategory(_sections[i]),
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.grey.shade300,
                                          size: 30,
                                        ),
                                        onPressed: () => print('tapped more'))
                                  ],
                                ),
                                BlocProvider(
                                  create: (context) => FilteredTodoBloc(
                                      todoBloc: context.read<TodoBloc>())
                                    ..add(FilteredTodoFilterChanged(
                                        TodoFilter.category)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BlocBuilder<FilteredTodoBloc,
                                          FilteredTodoState>(
                                        builder: (context, state) {
                                          return Text(
                                            '${state.todos.length} Tasks',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade400),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(_sections[i].getName().capitalize(),
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.grey.shade700)),
                                      SizedBox(height: 15),
                                      BlocBuilder<FilteredTodoBloc,
                                          FilteredTodoState>(
                                        builder: (context, state) {
                                          return CategoryProgressIndicator(
                                              color: _getColorForCategory(
                                                  _sections[i]),
                                              category: _sections[i],
                                              totalTodos: state.todos.length);
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
