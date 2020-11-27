import 'package:flutter/material.dart';
import 'package:shop_app/widgets/form.dart';

class AddProduct extends StatefulWidget {
  static final routeName = "/add_product";
  final String imagePath;

  const AddProduct({this.imagePath});

  @override
  AddProductState createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Page"),
      ),
      body: SafeArea(
          child: FormWidget(
        formKey: _formKey,
        imagePath: widget.imagePath,
      )),
    );
  }
}
