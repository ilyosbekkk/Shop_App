import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/utils/utils.dart';

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
  IconData emailValidationIcon, passwordValidationIcon;
  Color emailValidationColor, passwordValidationColor;
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
        child: TextFormField(
          decoration: InputDecoration(
              hintText: hintText,
              icon: hintText == "email"
                  ? Icon(emailValidationIcon, color: emailValidationColor)
                  : hintText == "password"
                      ? Icon(
                          passwordValidationIcon,
                          color: passwordValidationColor,
                        )
                      : Icon(
                          Icons.done,
                          color: Colors.green,
                        )),
          controller: textEditingController,
          keyboardType: textInputType,
          onChanged: (targetField) {
            if (hintText == "email") {
              if (!isEmailValid(targetField)) {
                emailValidationIcon = Icons.error;
                emailValidationColor = Colors.red;
              } else {
                emailValidationColor = Colors.green;
                emailValidationIcon = Icons.done;
              }
              setState(() {});
            } else if (hintText == "password") {
              if (targetField.length <= 4) {
                passwordValidationIcon = Icons.error;
                passwordValidationColor = Colors.red;
              } else {
                passwordValidationColor = Colors.green;
                passwordValidationIcon = Icons.done;
              }
              setState(() {});
            }
          },
        ));
  }

  Widget buildAuthButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Consumer<Authentication>(
            builder: (context, instance, child) => RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  if (authmode == AUTHMODE.SIGNUP) {
                    setState(() {
                      authmode = AUTHMODE.SIGNIN;
                    });
                  } else {
                    instance.signIn(emailAddress.text, password.text, context);
                  }
                },
                child: Text("SignIn")),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Consumer<Authentication>(
            builder: (context, instance, child) => RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  if (authmode == AUTHMODE.SIGNIN) {
                    setState(() {
                      authmode = AUTHMODE.SIGNUP;
                    });
                  } else {
                    instance.signUp(users, emailAddress.text, password.text, fullName.text, userName.text, context);
                  }
                },
                child: Text("Sign-Up")),
          ),
        )
      ],
    );
  }
}
