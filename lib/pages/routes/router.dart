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
      return _buildPageWithSlideTransition(
        () => CategoryDetailPage(settings.arguments as Category),
        settings,
      );
    case '/addtodo':
      return _buildPageWithSlideTransition(
          () => AddTodoPage(settings.arguments as Category), settings);
    default:
      return MaterialPageRoute(builder: (_) => SplashPage());
  }
}

Route _buildPageWithSlideTransition<T>(
  Widget Function() builder,
  RouteSettings settings,
) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) => builder(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var curve = Curves.ease;
      var curveTween = CurveTween(curve: curve);

      var tween =
          Tween(begin: Offset(0, 1), end: Offset(0, 0)).chain(curveTween);

      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: tween
            .animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
        child: child,
      );
    },
  );
}
