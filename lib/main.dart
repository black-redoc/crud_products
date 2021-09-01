import 'package:crud_products/routes.dart';
import 'package:flutter/material.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Products',
      debugShowCheckedModeBanner: false,
      routes: LocalRoutes.routes,
      initialRoute: '/login',
    );
  }
}