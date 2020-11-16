import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: GridTile(
        child: imageUrlWidget(),
        footer: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName,
                arguments: id);
          },
          child: GridTileBar(
            leading: favorites(),
            trailing: shoppingChart(),
            title: titleWidget(),
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget favorites() {
    return IconButton(
      icon: Icon(Icons.favorite),
      onPressed: () {},
    );
  }

  Widget shoppingChart() {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {},
    );
  }

  Widget titleWidget() {
    return Text(
      title,
      textAlign: TextAlign.center,
    );
  }

  Widget imageUrlWidget() {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
