import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth_screen.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: ListTile(
              leading: Image.asset("assets/images/google.jpg"),
              title: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Sign in with Google"),
                onPressed: () {},
              )),
        ),
        Container(
          child: ListTile(
              leading: Image.asset("assets/images/gmail.jpg"),
              title: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Sign in with email"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AuthScreen.routeName);
                },
              )),
        ),
      ],
    );
  }
}
