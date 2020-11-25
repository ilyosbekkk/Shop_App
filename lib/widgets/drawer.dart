import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products%20overview%20screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: ListView(
        children: [
          drawerHeader(),
          drawerSections(Icons.shopping_bag_rounded, "My Shop", () {
            Navigator.pushNamed(context, ProductsOverview.routeName);
          }),
          drawerSections(Icons.format_list_numbered_rounded, "My Orders", () {
            Navigator.pushNamed(context, MyOrders.routeName);
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
        size: 45,
        color: Colors.green,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
      child: Text(
        'Halal Shop',
        style: TextStyle(fontSize: 30),
      ),
      decoration: BoxDecoration(color: Colors.purple),
    );
  }
}
