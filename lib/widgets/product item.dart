import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///D:/Flutter%20Projects/shop_app/lib/providers/product.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Product>(context, listen: false);

    print("build is called");
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: GridTile(
        child: imageUrlWidget(item.imageUrl),
        footer: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName,
                arguments: item.id);
          },
          child: GridTileBar(
            leading: Consumer<Product>(
                builder: (context, item, child) => favorites(item)),
            trailing: shoppingChart(),
            title: titleWidget(item.title),
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget favorites(Product product) {
    return IconButton(
      icon: product.isFavorite
          ? Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
      onPressed: product.toggleFavoriteStatus,
    );
  }

  Widget shoppingChart() {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {},
    );
  }

  Widget titleWidget(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
    );
  }

  Widget imageUrlWidget(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
