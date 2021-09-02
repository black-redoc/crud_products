import 'package:crud_products/data/product.dart';
import 'package:crud_products/util/colors.dart';
import 'package:flutter/material.dart';

class ProductFormPage extends StatelessWidget {
  final bool isUpdate;
  final Product? product;
  const ProductFormPage({
    Key? key,
    this.isUpdate = false,
    this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            _titleBar(
              height: size.height,
              width: size.width,
              context: context
            ),
          ]
        )
      ),
    );
  }

  Widget _titleBar({ 
    double? height,
    double? width,
    BuildContext? context 
  }) => Container(
    height: height! * 0.23,
    width: width,
    color: LocalColors.purple_dark,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _backButton(context!),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "${isUpdate ? 'Actualizar' : 'Crear'} producto",
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

  Widget _backButton(BuildContext context) => IconButton(
    icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
    onPressed: () => Navigator.of(context).pop()
  );
}