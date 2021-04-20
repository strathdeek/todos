import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/data/bloc/register/register_bloc.dart';
import 'package:todos/widgets/curve.dart';

class RegisterPage extends StatelessWidget {
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
                        'Create\nAccount',
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
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return TextField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onChanged: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(RegisterEmailChanged(email: value));
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
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return TextField(
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          onChanged: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(RegisterPasswordChanged(password: value));
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
                    SizedBox(height: 25),
                    BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        return TextField(
                          style: TextStyle(color: Colors.black),
                          autocorrect: false,
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(
                                RegisterConfirmPasswordChanged(
                                    confirmPassword: value));
                          },
                          decoration: InputDecoration(
                            errorText: state.confirmPasswordError,
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Confirm Password',
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
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        onPressed: () => context
                            .read<RegisterBloc>()
                            .add(RegisterSubmitted()),
                        child: Text('Create Account'))
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
