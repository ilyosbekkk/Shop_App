import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_screen.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            user != null
                ? ListTile(title: Text("User:"), trailing: Text("loading.."), subtitle: Text(user.email))
                : RaisedButton(

                    child: Text("Sign in"),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AuthScreen.routeName);
                    })
          ],
        ),
      ),
    );
  }
}
