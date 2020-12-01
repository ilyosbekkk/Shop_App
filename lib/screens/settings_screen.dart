import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';

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
          children: [
            ListTile(
              title: Text("User:"),
              trailing: Text("Ilyosbek Ibrokhimov"),
              subtitle: Text(user.email),
            )
          ],
        ),
      ),
    );
  }
}
