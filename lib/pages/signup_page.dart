import 'package:crud_products/util/clippers/bottonWaveClipper.dart';
import 'package:crud_products/util/colors.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  bool _obscurePassword = true;
  Icon _passwordVisibilityIcon = Icon(Icons.visibility);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          children: <Widget>[
            _background(height: size.height),
            _formSignup(height: size.height, width: size.width, context: context),
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

  Widget _formSignup({
    double? height,
    double? width,
    BuildContext? context
  }) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            height: height! * 0.68,
            width: width! * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5
                )
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    _formTitle(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                        left: 80,
                        right: 80
                      ),
                      child: Divider(
                        color: Colors.black45,
                        thickness: 1,
                      )
                    ),
                  ],
                ),
                _formFields(),
                _submitButton(context: context),
                _formLoginRedirection(context: context),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget _formTitle() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Registrate",
        style: TextStyle(
          fontSize: 24,
          letterSpacing: 0.8
        )
      )
    ],
  );

  Widget _formFields() => Container(
    height: 160,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          style: TextStyle(
            fontSize: 14
          ),
          decoration: InputDecoration(
            labelText: "email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 25
            )
          ),
        ),
        TextFormField(
          controller: _passwordController,
          style: TextStyle(
            fontSize: 14
          ),
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: "contraseña",
            suffixIcon: IconButton(
              icon: Container(child: _passwordVisibilityIcon),
              onPressed: _onPasswordVisibilityChange,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 25
            )
          ),
        ),
        TextFormField(
          controller: _confirmPasswordController,
          style: TextStyle(
            fontSize: 14
          ),
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: "confirmar contraseña",
            suffixIcon: IconButton(
              icon: Container(child: _passwordVisibilityIcon),
              onPressed: _onPasswordVisibilityChange,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 25
            )
          ),
        )
      ]
    ),
  );

  Widget _submitButton({BuildContext? context}) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      MaterialButton(
        onPressed: () => _onSubmit(context: context),
        color: Colors.red,
        child: Text(
          "Registrar",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white
          )
        ),
      )
    ],
  );

  Widget _formLoginRedirection({BuildContext? context}) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Text(
        "Ya tienes cuenta? ",
        style: TextStyle(
          fontSize: 14,
        )
      ),
      TextButton(
        onPressed: () => _redirectToLogin(context: context),
        child: Text(
          "Inicia sesión!",
          style: TextStyle(
            fontSize: 15,
          )
        )
      )
    ],
  );

  void _onSubmit({BuildContext? context}) {
    Navigator.of(context!).pushNamed("/");
  }

  void _redirectToLogin({
    BuildContext? context
  }) => Navigator.of(context!).pushNamed("/login");


  void _onPasswordVisibilityChange() {
    setState(() {
      if (_obscurePassword) {
        _passwordVisibilityIcon = Icon(Icons.visibility_off);
      } else {
        _passwordVisibilityIcon = Icon(Icons.visibility);
      }
      _obscurePassword = !_obscurePassword;
    });
  }
}
