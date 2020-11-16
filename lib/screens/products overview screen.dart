import 'package:flutter/material.dart';
import 'file:///D:/Flutter%20Projects/shop_app/lib/providers/product.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heightOfScreen = MediaQuery.of(context).size.height;
    final widthOftheScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Halal Shop"),
        ),
        body: ProductGrid(
          screenWidth: widthOftheScreen,
          screenHeight: heightOfScreen,
        ));
  }
}
