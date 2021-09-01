import 'package:crud_products/repository/user_repository.dart';
import 'package:crud_products/util/clippers/bottonWaveClipper.dart';
import 'package:crud_products/util/colors.dart';
import 'package:crud_products/util/validators/user_validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  Icon? _passwordVisibilityIcon;
  bool _obscurePassword = true;
  UserRepository? _userRepository;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisibilityIcon = Icon(Icons.visibility);
    _userRepository = UserRepository();
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
            _formLogin(height: size.height, width: size.width, context: context),
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

  Widget _formLogin({
    double? height,
    double? width,
    BuildContext? context
  }) {
    return Positioned(
      right: 0,
      left: 0,
      top: 0,
      bottom: 0,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            height: height! * 0.65,
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
                  children: <Widget>[
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
                  ]
                ),
                _formFields(),
                _submitButton(context: context),
                _formSignUpRedirection(context: context),
              ]
            ),
          ),
        ),
      )
    );
  }

  Widget _formTitle() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Inicia sesión",
        style: TextStyle(
          fontSize: 24,
          letterSpacing: 0.8
        )
      )
    ],
  );

  Widget _formFields() => Container(
    height: 150,
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
          "Iniciar",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white
          )
        ),
      )
    ],
  );

  Widget _formSignUpRedirection({BuildContext? context}) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "Aún no tienes cuenta? ",
            style: TextStyle(
              fontSize: 15,
            )
          ),
          TextButton(
            onPressed: () => _redirectToSignUp(context: context),
            child: Text(
              "Registrate!",
              style: TextStyle(
                fontSize: 15,
              )
            )
          )
        ],
      )
    ],
  );

  void _redirectToSignUp({
    BuildContext? context
  }) => Navigator.of(context!).pushNamed("/signup");

  void _onSubmit({BuildContext? context}) async{
    if (!UserValidator.isEmailValid(email: _emailController!.text)) {
      ScaffoldMessenger
      .of(context!)
      .showSnackBar(
        SnackBar(
          content: Text("El email es invalido, debe ser como este user@example.com")
        )
      );
    } else if (!UserValidator.isPasswordValid(password: _passwordController!.text)) {
      ScaffoldMessenger
      .of(context!)
      .showSnackBar(
        SnackBar(
          content: Text(
            "La contraseña es invalida, debe tener minimo 8 caracteres, "
            "1 letra y 1 número."
          )
        )
      );
    } else {
      try {
        final user = await _userRepository!.signInWithCredentials(
          _emailController!.text,
          _passwordController!.text
        );

        ScaffoldMessenger
        .of(context!)
        .showSnackBar(
          SnackBar(
            content: Text(
              "Inicio con exito!"
            )
          )
        );
        Navigator.of(context).pushNamed("/");
      } catch (e) {
        ScaffoldMessenger
        .of(context!)
        .showSnackBar(
          SnackBar(
            content: Text(
              "Credenciales incorrectas!"
            )
          )
        );
      }
    }
  }

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
