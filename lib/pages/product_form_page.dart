import 'package:crud_products/data/product.dart';
import 'package:crud_products/repository/product_repository.dart';
import 'package:crud_products/util/colors.dart';
import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  final bool isUpdate;
  final Product? product;

  ProductFormPage({
    Key? key,
    this.isUpdate = false,
    this.product,
  }) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ProductRepository _productRepository = ProductRepository.create();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _nameController.value = TextEditingValue(text: widget.product?.name ?? "");
      _descriptionController.value = TextEditingValue(
        text: widget.product?.description ?? ""
      );
      _stockController.value = TextEditingValue(text: "${widget.product?.stock}");
      _priceController.value = TextEditingValue(text: "${widget.product?.price}");
    }
  }

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
            _productForm()
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
                "${widget.isUpdate ? 'Actualizar' : 'Crear'} producto",
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

  Widget _productForm() => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextFormField(
                    readOnly: widget.isUpdate,
                    controller: _nameController,
                    style: TextStyle(
                      fontSize: 14
                    ),
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 25
                      )
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(
                      fontSize: 14
                    ),
                    decoration: InputDecoration(
                      labelText: "Descripcción",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 25
                      )
                    ),
                  ),
                  TextFormField(
                    controller: _stockController,
                    style: TextStyle(
                      fontSize: 14
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Stock",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 25
                      )
                    ),
                  ),
                  TextFormField(
                    controller: _priceController,
                    style: TextStyle(
                      fontSize: 14
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Pecio",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 25
                      )
                    ),
                  )
                ]
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                  color: Colors.red,
                  child: Text(
                    "Guardar",
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                  onPressed: _onSubmit
                )
              ]
            )
          ]
        ),
      ),
    ),
  );

  void _onSubmit() {
    if (
      _nameController.value.text.length < 1
      || _descriptionController.value.text.length < 1
      || _stockController.value.text.length < 1
      || _priceController.value.text.length < 1
    ) {
      ScaffoldMessenger
        .of(context)
        .showSnackBar(
          SnackBar(
            content: Text("No pueden haber campos vacios")
          )
        );
    } else {
      try {
        final product = Product.fromMap({
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": '${_priceController.text}',
          "stock": '${_stockController.text}'
        });
        if (widget.isUpdate) {
          _productRepository.updateProduct(product);
        } else {
          _productRepository.createProduct(product);
        }
        ScaffoldMessenger
        .of(context)
        .showSnackBar(
          SnackBar(
            content: Text("${widget.isUpdate ? 'Actualizado' : 'Creado'} con exito!")
          )
        );
        Navigator.of(context).pushNamed("/");
      } catch (error) {
        ScaffoldMessenger
        .of(context)
        .showSnackBar(
          SnackBar(
            content: Text("Error al guardar el producto")
          )
        );
      }
    }
  }
}