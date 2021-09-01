import 'package:crud_products/pages/home_page.dart';
import 'package:crud_products/pages/login_page.dart';
import 'package:crud_products/pages/signup_page.dart';
import 'package:flutter/material.dart' show BuildContext, WidgetBuilder;


class LocalRoutes {
  static final Map<String, WidgetBuilder> _routes = {
    "/login": (BuildContext context) => LoginPage(),
    "/signup": (BuildContext context) => SignupPage(),
    "/": (BuildContext context) => HomePage()
  };

  static Map<String, WidgetBuilder> get routes => _routes;
}
