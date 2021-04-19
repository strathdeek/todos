import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/bloc/login/login_bloc.dart';

class RegisterPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  String _emailError = '';
  String _passwordError = '';
  String _confirmPasswordError = '';

  bool get _emailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(_email);

  bool _verifyEmailInput() {
    setState(() {
      _emailError = !_emailValid ? 'Please use a valid email address' : '';
    });
    return _emailValid;
  }

  bool _verifyPasswordInput() {
    setState(() {
      _passwordError = _password.isEmpty ? 'Password not long enough' : '';
      _confirmPasswordError =
          (_confirmPassword.isNotEmpty && _password != _confirmPassword)
              ? 'Passwords do not match'
              : '';
    });

    return _passwordError.isEmpty &&
        _confirmPasswordError.isEmpty &&
        _confirmPassword.isNotEmpty;
  }

  void _registerAccount() {
    if (_verifyEmailInput() && _verifyPasswordInput()) {
      BlocProvider.of<LoginBloc>(context)
          .add(RegisterButtonPressed(_email, _password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Email'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              onEditingComplete: _verifyEmailInput,
              decoration: InputDecoration(errorText: _emailError),
            ),
            SizedBox(height: 50),
            Text('Password'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(errorText: _passwordError),
              onEditingComplete: _verifyPasswordInput,
            ),
            SizedBox(height: 50),
            Text('Confirm Password'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              onEditingComplete: _verifyPasswordInput,
              decoration: InputDecoration(errorText: _confirmPasswordError),
            ),
            ElevatedButton(
                onPressed: _registerAccount, child: Text('Create Account'))
          ],
        ),
      ),
    );
  }
}
