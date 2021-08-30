import 'package:crud_products/util/clippers/bottonWaveClipper.dart';
import 'package:crud_products/util/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          children: <Widget>[
            _background(height: size.height)
          ]
        ),
      )
    );
  }

  Widget _background({height: double}) {
    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Container(
        height: height / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              LocalColors.purple_primary,
              LocalColors.purple_secondary
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
      ),
    );
  }
}
