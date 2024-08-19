import 'package:flutter/material.dart';
import 'package:shopipi_mobile_v2/screens/auth/loginPage.dart';
import 'package:shopipi_mobile_v2/screens/home/index.dart';
import 'package:shopipi_mobile_v2/screens/profile/profileScreen.dart';

class Router {
  final String name;
  final Widget Function(BuildContext, RouteSettings) builder;

  Router(this.name, this.builder);
}

final List<Router> routes = [
  Router('/', (c, s) => HomeScreen()),
  Router('/category', (c, s) => Container()),
  Router('/product', (c, s) => Container()),
  Router('/cart', (c, s) => Container()),
  Router('/profile', (c, s) => ProfileScreen()),
  //
  Router('/login', (c, s) => LoginPage())
];

Route<dynamic>? generateRoute(RouteSettings settings) {
  final route = routes.firstWhere(
    (route) => route.name == settings.name,
    orElse: () => routes.first,
  );

  return MaterialPageRoute(
      builder: (context) => route.builder(context, settings),
      settings: settings);
}
