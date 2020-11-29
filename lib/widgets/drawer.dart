import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products%20overview%20screen.dart';
import 'package:shop_app/screens/settings_screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);

    return SafeArea(
        child: Drawer(
      child: ListView(
        children: [
          drawerHeader(),
          drawerSections(Icons.shopping_bag_rounded, "My Shop", () {
            Navigator.pushNamed(context, ProductsOverview.routeName);
          }),
          Divider(),
          drawerSections(Icons.format_list_numbered_rounded, "My Orders", () {
            Navigator.pushNamed(context, MyOrders.routeName);
          }),
          Divider(),
          drawerSections(Icons.add_box_rounded, "Product Management", () {
            Navigator.pushNamed(context, AddProduct.routeName);
          }),
          Divider(),
          drawerSections(Icons.access_time_rounded, "Prayer Times", () {
            Navigator.pushNamed(context, MyOrders.routeName);
          }),
          Divider(),
          drawerSections(Icons.money, "Donate", () {
            Navigator.pushNamed(context, MyOrders.routeName);
          }),
          Divider(),
          drawerSections(Icons.fiber_new_sharp, "Islamic News", () {
            Navigator.pushNamed(context, MyOrders.routeName);
          }),
          Divider(),
          drawerSections(Icons.settings, "Settings", () {
            Navigator.pushNamed(context, SettingsScreen.routeName);
          }),
          Divider(),
          if (auth.isAuthenticated)
            drawerSections(Icons.login, "SignOut", () {
              auth.signOut(context).whenComplete(() {
                print(auth.isAuthenticated);
                Navigator.pushNamed(context, ProductsOverview.routeName);
              });
            }),
          if (!auth.isAuthenticated)
            drawerSections(Icons.login, "SignIn", () {
              print(auth.isAuthenticated);
              Navigator.pushReplacementNamed(context, AuthScreen.routeName);
            }),
        ],
      ),
    ));
  }

  Widget drawerSections(IconData icon, String title, Function function) {
    return ListTile(
      onTap: function,
      leading: Icon(
        icon,
        size: 35,
        color: Colors.black38,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
      child: Column(
        children: [
          Text(
            'Halal Shop',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Container(
            width: 100,
            height: 100,
            child: Image.network("https://i.pinimg.com/originals/31/1e/34/311e34b19daf03cd70feaac8edb2b198.png"),
          )
        ],
      ),
      decoration: BoxDecoration(color: Colors.purple),
    );
  }
}
