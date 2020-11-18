import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product%20item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final screenWidth, screenHeight;
  final showOnlyFavorites;

  const ProductGrid(
      {this.screenWidth, this.screenHeight, this.showOnlyFavorites});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showOnlyFavorites ? productsData.favorites : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: screenWidth * 0.05,
          mainAxisSpacing: screenHeight * 0.01),
    );
  }
}
