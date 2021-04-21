import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/authentication/authentication_bloc.dart';
import 'package:todos/data/bloc/bloc/filtered_todo_bloc.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/constants/enums.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/widgets/avatar.dart';
import 'package:todos/widgets/category_icon.dart';
import 'package:todos/widgets/category_sumary.dart';
import 'package:todos/widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;

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
            color: _sections[_index].getColor(),
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
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/detail', arguments: _sections[i]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 15, bottom: 30),
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 20, left: 20, right: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CategoryIcon(category: _sections[i]),
                                        IconButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Colors.grey.shade300,
                                              size: 30,
                                            ),
                                            onPressed: () =>
                                                print('tapped more'))
                                      ],
                                    ),
                                    CategorySummary(category: _sections[i])
                                  ],
                                ),
                              ),
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
