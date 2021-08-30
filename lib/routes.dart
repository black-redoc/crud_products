import 'package:crud_products/pages/login_page.dart';
import 'package:flutter/material.dart' show BuildContext, WidgetBuilder;


class LocalRoutes {
  static final Map<String, WidgetBuilder> _routes = {
    "/login": (BuildContext context) => LoginPage()
  };

  static Map<String, WidgetBuilder> get routes => _routes;
}
