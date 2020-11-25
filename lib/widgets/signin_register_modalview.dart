import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          leading: Image.asset("assets/images/google.jpg"),
          title: RaisedButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Text("SignIn/Register"),
            onPressed: () {},
          )),
    );
  }
}
