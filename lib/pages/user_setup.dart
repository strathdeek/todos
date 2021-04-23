import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/authentication/authentication_bloc.dart';
import 'package:todos/data/bloc/register/register_bloc.dart';
import 'package:todos/data/bloc/user/user_bloc.dart';
import 'package:todos/data/models/index.dart';
import 'package:todos/widgets/curve.dart';

class UserSetupPage extends StatefulWidget {
  @override
  _UserSetupPageState createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  String _name = '';
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                LayoutBuilder(
                  builder: (context, constraints) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                    width: constraints.widthConstraints().maxWidth,
                    height: constraints.heightConstraints().maxHeight,
                    child: CustomPaint(
                      painter: CurvePainter(color: primaryColor),
                    ),
                  ),
                ),
                AnimatedAlign(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        'User\nDetails',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    ))
              ]),
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return TextField(
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Name',
                            prefixIcon: Icon(
                              Icons.badge,
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                          cursorColor: primaryColor,
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        onPressed: () {
                          var authenticationState =
                              context.read<AuthenticationBloc>().state;
                          if (authenticationState
                              is AuthenticationAuthenticated) {
                            context.read<UserBloc>().add(UserCreated(User(
                                _name,
                                authenticationState.email,
                                authenticationState.userId)));
                          }
                        },
                        child: Text('Continue')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
