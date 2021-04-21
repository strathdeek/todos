import 'package:flutter/material.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/pages/add_todo_page.dart';
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
    case '/detail':
      return MaterialPageRoute(
          builder: (_) => CategoryDetailPage(settings.arguments as Category));
    case '/addtodo':
      return MaterialPageRoute(
          builder: (_) => AddTodoPage(settings.arguments as Category));
    default:
      return MaterialPageRoute(builder: (_) => SplashPage());
  }
}
