import 'package:crud_products/data/product.dart';
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
    return Scaffold(
      body: Center(
        child: Text(
          "${isUpdate ? 'Actualizar' : 'Crear'} Producto"
        )
      ),
    );
  }
}