import 'package:crud_products/util/colors.dart';
import 'package:flutter/cupertino.dart';
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
            _titleBar(height: size.height, width: size.width),
            Expanded(
              child: _productList(width: size.width)
            ),
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

  Widget _productList({ double? width }) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 10,
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
            confirmDismiss: (DismissDirection direction) =>
                _confirmDismiss(idx),
            child: ListTile(
              title: Center(
                child:
                  Text(
                    "$idx",
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
              ),
            ),
            background: _slideRightBackground(),
            secondaryBackground: _slideLeftBackground(),
          ),
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

  Future<bool> _confirmDismiss(int id) async {
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
              onPressed: () => _deleteInterest(id)
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

  void _deleteInterest(id) {

  }
}