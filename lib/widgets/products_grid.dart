import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product%20item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final screenWidth,  screenHeight;

  const ProductGrid({ this.screenWidth, this.screenHeight});

  @override
  Widget build(BuildContext context) {
   final productsData =  Provider.of<Products>(context);
   final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductItem(products[index].id,
          products[index].title, products[index].imageUrl),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: screenWidth * 0.05,
          mainAxisSpacing: screenHeight * 0.01),
    );
  }
}
