import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'file:///D:/Flutter%20Projects/shop_app/lib/providers/product.dart';
import 'package:shop_app/widgets/products_grid.dart';
import 'package:shop_app/widgets/drawer.dart';

enum FilteredItmes { FAVORITES, ALL }

class ProductsOverview extends StatefulWidget {
  static String routeName = "/";

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool showOnlyFavorites = false;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final heightOfScreen = MediaQuery
        .of(context)
        .size
        .height;
    final widthOftheScreen = MediaQuery
        .of(context)
        .size
        .width;
    CollectionReference products = FirebaseFirestore.instance.collection(
        'products');

    Future<void> addItem() {
      return products.add({
        'name': "Olma",
        'price': "4.99",
        'quantity': "5",

      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Halal Shop"),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == FilteredItmes.FAVORITES) {
                  setState(() {
                    showOnlyFavorites = true;
                  });
                } else {
                  setState(() {
                    showOnlyFavorites = false;
                  });
                }
              },
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                    child: Text("Favorites"), value: FilteredItmes.FAVORITES),
                PopupMenuItem(child: Text("All"), value: FilteredItmes.ALL),
              ],
            ),
            Consumer<Cart>(
              builder: (context, cart, child) =>
                  Badge(child: child, value: cart.items.length.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routName);
                },
                icon: Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
        body: Container(child: RaisedButton(
          child: Text("Add"), onPressed: addItem
        ),)
      //drawer: DrawerWidget(),
    );
  }


}


/*
ProductGrid(
        screenWidth: widthOftheScreen,
        screenHeight: heightOfScreen,
        showOnlyFavorites: showOnlyFavorites,
      ),
 */
