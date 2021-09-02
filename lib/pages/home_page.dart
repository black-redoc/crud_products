import 'package:crud_products/data/product.dart';
import 'package:crud_products/pages/product_form_page.dart';
import 'package:crud_products/repository/product_repository.dart';
import 'package:crud_products/util/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ProductRepository _productRepository;

  @override
  void initState() {
    super.initState();
    _productRepository = ProductRepository.create();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            _titleBar(height: size.height, width: size.width),
            Expanded(
              child: _productList(width: size.width)
            ),
          ]
        ),
      ),
      floatingActionButton: _createProductButton(),
    );
  }

  Widget _createProductButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: <BoxShadow>[
          BoxShadow(color: LocalColors.purple_dark, blurRadius: 2)
        ]
      ),
      child: IconButton(
        icon: Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductFormPage(
              isUpdate: false,
            )
          )
        )
      ),
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

  Widget _productList({ double? width }) {
    return FutureBuilder(
      future: _productRepository.getProducts(),
      builder: (_, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final products = snapshot.data ?? [];
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, idx) {
              return Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                    bottom: (idx == (List.generate(10, (i) => i).length - 1))
                      ? BorderSide(color: Colors.grey, width: 0.5)
                      : BorderSide.none,
                  )
                ),
                child: Dismissible(
                  key: Key("$idx"),
                  confirmDismiss: (DismissDirection direction) {
                    if (direction == DismissDirection.startToEnd) {
                      return _confirmDismiss(products[idx]);
                    } else {
                      return _showUpdatePage(products[idx]);
                    }
                  },
                  child: ListTile(
                    title: Center(
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:<Widget>[
                            Text(
                              "${products[idx].name}",
                              softWrap: true,
                              style: TextStyle(
                                color: LocalColors.purple_dark,
                              )
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "(${products[idx].stock})",
                                  style: TextStyle(
                                    color: Colors.grey
                                  )
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "\$${products[idx].price}",
                                  style: TextStyle(
                                    color: Colors.green
                                  )
                                )
                              ]
                            )
                          ]
                        )
                    ),
                  ),
                  background: _slideRightBackground(),
                  secondaryBackground: _slideLeftBackground(),
                ),
              );
            }
          );
        }
        return Center(
          child: CircularProgressIndicator()
        );
      }
    );
  }

  Widget _slideRightBackground() => Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Eliminar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );

  Widget _slideLeftBackground() => Container(
    color: LocalColors.purple_primary,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            " Editar",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );

  Future<bool> _confirmDismiss(Product product) async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(width: 20),
              Text("Confirmación"),
              IconButton(
                onPressed: () => _backPage(context),
                icon: Icon(Icons.clear_rounded, size: 20)
              )
            ],
          ),
          content: Text("Desea eliminar este item?"),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              child: Text(
                "Eliminar",
                style: TextStyle(
                  color: Colors.white
                )
              ),
              onPressed: () => _deleteProduct(product)
            ),
          ],
        );
      }
    );
    return response;
  }

  void _backPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _deleteProduct(Product product) async {
    await _productRepository.deleteProduct(product);
  }

  Future<bool> _showUpdatePage(Product product) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductFormPage(
        product: product,
        isUpdate: true
      )
    ));
    return false;
  }
}