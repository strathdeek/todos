import 'package:flutter/material.dart';
import 'package:todos/pages/index.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute<void>(builder: (_) => DashboardPage());
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginPage());
    case '/register':
      return MaterialPageRoute(builder: (_) => RegisterPage());
    case '/profile':
      return MaterialPageRoute(builder: (_) => ProfilePage());
    default:
      return MaterialPageRoute(builder: (_) => SplashPage());
  }
}
