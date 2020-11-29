import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/settings";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),

      body: SafeArea(
          child: Consumer<Authentication>(
              builder: (context, instance, child) =>
                  Column(
                    children: [
                      ListTile(
                        title: Text("User:"),
                        trailing: Text(instance.fullName),
                        subtitle: Text(instance.email),
                      )
                    ],
                  ),
          )
      ),
    );
  }
}
