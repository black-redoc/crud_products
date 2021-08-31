import 'package:crud_products/util/clippers/bottonWaveClipper.dart';
import 'package:crud_products/util/colors.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        )
      )
    );
  }

  Widget _background({ double? height }) => ClipPath(
    clipper: BottomWaveClipper(),
    child: Container(
      height: height! / 2,
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
