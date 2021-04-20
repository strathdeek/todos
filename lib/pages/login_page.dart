import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/login/login_bloc.dart';
import 'package:todos/widgets/curve.dart';

class LoginPage extends StatelessWidget {
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
                        'Welcome\nBack',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      return Text(
                        state.apiError,
                        style: TextStyle(color: Colors.red),
                      );
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return TextField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(LoginEmailChanged(email: value));
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            errorText: state.emailError,
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                          cursorColor: primaryColor,
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return TextField(
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(LoginPasswordChanged(password: value));
                          },
                          decoration: InputDecoration(
                            errorText: state.passwordError,
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                          ),
                          cursorColor: primaryColor,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginSubmitted());
                        },
                        child: Text('Log in')),
                    Container(
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
                              child: Divider(
                                color: Colors.grey.shade500,
                                height: 30,
                              )),
                        ),
                        Text(
                          'or',
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 15),
                        ),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
                              child: Divider(
                                color: Colors.grey.shade500,
                                height: 30,
                              )),
                        ),
                      ]),
                    ),
                    OutlinedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                '/register', (route) => false),
                        child: Text('Sign up')),
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
