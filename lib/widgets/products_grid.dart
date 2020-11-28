import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product%20item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatefulWidget {
  final screenWidth, screenHeight;

  ProductGrid({this.screenWidth, this.screenHeight});

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return productsData.onlyFavorites && products.isEmpty
        ? noFavorites(productsData)
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: ProductItem(item: products[index]),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: widget.screenWidth * 0.05,
                mainAxisSpacing: widget.screenHeight * 0.01),
          );
  }

  Widget noFavorites(Products products) {
    return Center(
      child: Column(
        children: [
          Text(
            "No Favorite items found!",
            style: TextStyle(fontSize: 20),
          ),
          RaisedButton(
            onPressed: () {
              products.showOnlyFavorites = false;
            },
            color: Colors.green,
            child: Text("See all"),
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
