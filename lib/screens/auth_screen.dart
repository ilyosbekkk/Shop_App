import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/products%20overview%20screen.dart';

class AuthScreen extends StatelessWidget {
  static final routeName = "/auth_screen";
  final emailAddress = TextEditingController();
  final password = TextEditingController();

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
          textFormField(emailAddress, "fullname", TextInputType.name),
          textFormField(emailAddress, "username", TextInputType.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {},
                child: Text("Login"),
              ),
              Text("or"),
              Consumer<Authentication>(
                builder: (context, instance, child) => RaisedButton(
                    onPressed: () {
                      instance.signUp(emailAddress.text, password.text);
                      instance.authState();
                      Navigator.pushReplacementNamed(
                          context, ProductsOverview.routeName);
                    },
                    child: Text("SignUp")),
              )
            ],
          ),
        ],
      ),
    ));
  }

  Widget textFormField(TextEditingController textEditingController,
      String hintText, TextInputType textInputType) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
          decoration: InputDecoration(hintText: hintText),
          controller: textEditingController,
          keyboardType: textInputType),
    );
  }
}
