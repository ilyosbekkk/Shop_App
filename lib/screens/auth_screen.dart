import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/products%20overview%20screen.dart';

enum AUTHMODE { SIGNIN, SIGNUP }

class AuthScreen extends StatefulWidget {
  static final routeName = "/auth_screen";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailAddress = TextEditingController();

  final password = TextEditingController();

  final fullName = TextEditingController();

  final userName = TextEditingController();

  AUTHMODE authmode = AUTHMODE.SIGNIN;

  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        title: Text("User Authentication"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textFormField(emailAddress, "email", TextInputType.emailAddress),
          textFormField(password, "password", TextInputType.visiblePassword),
          if (authmode == AUTHMODE.SIGNUP) textFormField(fullName, "fullname", TextInputType.name),
          if (authmode == AUTHMODE.SIGNUP) textFormField(userName, "username", TextInputType.name),
          buildAuthButtons(context),
        ],
      ),
    ));
  }

  Widget textFormField(TextEditingController textEditingController, String hintText, TextInputType textInputType) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(decoration: InputDecoration(hintText: hintText), controller: textEditingController, keyboardType: textInputType),
    );
  }

  Widget buildAuthButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Consumer<Authentication>(
          builder: (context, instance, child) => RaisedButton(
              onPressed: () {
                if (authmode == AUTHMODE.SIGNUP) {
                  setState(() {
                    authmode = AUTHMODE.SIGNIN;
                  });
                } else {
                  instance.signIn(emailAddress.text, password.text, context).whenComplete(() {
                    instance.authState(context);
                    if (instance.isAuthenticated) Navigator.pushReplacementNamed(context, ProductsOverview.routeName);
                  });
                }
              },
              child: Text("SignIn")),
        ),
        Text("or"),
        Consumer<Authentication>(
          builder: (context, instance, child) => RaisedButton(
              onPressed: () {
                if (authmode == AUTHMODE.SIGNIN) {
                  setState(() {
                    authmode = AUTHMODE.SIGNUP;
                  });
                } else {
                  instance.signUp(users, emailAddress.text, password.text, fullName.text, userName.text, context).whenComplete(() {
                    instance.authState(context);
                    if (instance.isAuthenticated) Navigator.pushReplacementNamed(context, ProductsOverview.routeName);
                  });
                }
              },
              child: Text("Sign-Up")),
        )
      ],
    );
  }
}
