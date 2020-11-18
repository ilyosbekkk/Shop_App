import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'file:///D:/Flutter%20Projects/shop_app/lib/providers/product.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilteredItmes { FAVORITES, ALL }

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final heightOfScreen = MediaQuery.of(context).size.height;
    final widthOftheScreen = MediaQuery.of(context).size.width;
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
              itemBuilder: (context) => [
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
        body: ProductGrid(
          screenWidth: widthOftheScreen,
          screenHeight: heightOfScreen,
          showOnlyFavorites: showOnlyFavorites,
        ));
  }
}
