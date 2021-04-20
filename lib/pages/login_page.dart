import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  void _navigateToRegistration(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/register', (route) => false);
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
            TextField(),
            SizedBox(
              height: 50,
            ),
            Text('Password'),
            TextField(),
            TextButton(
                onPressed: () => _navigateToRegistration(context),
                child: Text('Create Account'))
          ],
        ),
      ),
    );
  }
}
