import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/camera_provider.dart';
import 'package:shop_app/widgets/form.dart';

class AddProduct extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static final routeName = "/add_product";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Page"),
      ),
      body: SafeArea(
          child: FormWidget(
        formKey: _formKey,
      )),
    );
  }
}
