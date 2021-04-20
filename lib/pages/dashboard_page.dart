import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/authentication/authentication_bloc.dart';
import 'package:todos/data/bloc/login/login_bloc.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/widgets/avatar.dart';
import 'package:todos/widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;
  final _sections = <Category>[
    Category(
        name: 'Personal',
        color: Color.fromARGB(255, 231, 130, 109),
        iconData: Icons.person),
    Category(
        name: 'Work',
        color: Color.fromARGB(255, 99, 137, 223),
        iconData: Icons.work),
    Category(
        name: 'Home',
        color: Color.fromARGB(255, 112, 194, 173),
        iconData: Icons.home),
  ];

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
          Text(
            'Welcome!\nYou have 3 tasks to do today',
            style: TextStyle(fontSize: 20, color: Colors.grey.shade200),
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
            color: _sections[_index].color,
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
                                        _sections[i].iconData,
                                        color: _sections[i].color,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '9 Tasks',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade400),
                                    ),
                                    SizedBox(height: 10),
                                    Text(_sections[i].name,
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: Colors.grey.shade700)),
                                    SizedBox(height: 15),
                                    LinearProgressIndicator(
                                      value: _sections[i].progress,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          _sections[i].color),
                                    )
                                  ],
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
