import 'dart:convert';

import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DashboardPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 130, 109),
      appBar: AppBar(
        title: Text('TODO'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Text('option1'),
          ],
        ),
      ),
      body: Center(
        child: Text('dashboard'),
      ),
    );
  }
}
