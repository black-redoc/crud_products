import 'package:crud_products/pages/login_page.dart';
import 'package:crud_products/pages/signup_page.dart';
import 'package:flutter/material.dart' show BuildContext, WidgetBuilder;


class LocalRoutes {
  static final Map<String, WidgetBuilder> _routes = {
    "/login": (BuildContext context) => LoginPage(),
    "/signup": (BuildContext context) => SignupPage()
  };

  static Map<String, WidgetBuilder> get routes => _routes;
}
