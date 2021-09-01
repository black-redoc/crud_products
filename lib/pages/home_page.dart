import 'package:crud_products/util/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            _titleBar(height: size.height, width: size.width)
          ]
        ),
      )
    );
  }

  Widget _titleBar({ double? height, double? width }) => Container(
    height: height! * 0.23,
    width: width,
    color: LocalColors.purple_dark,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Productos",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white70
                )
              ),
            )
          ],
        )
      ]
    )
  );
}