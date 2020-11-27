import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product =
        Provider.of<Products>(context, listen: false).findById(productId);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
          children: [
            Container(
                width: width,
                height: height * 0.3,
                child: imageUrlWidget(product.imageUrl)),
            titleWidget(product.title),
            Container(margin:  EdgeInsets.only(bottom: 20),
                child: Text(
                  ("Price: \$${product.price}"),
                  style: TextStyle(color: Colors.black45),
                )),
            buttons()
          ],
        ),
  );
  }

  Widget imageUrlWidget(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }

  Widget titleWidget(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
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
      onPressed: null
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          onPressed: () {},
          color: Colors.green,
          textColor: Colors.white,
          child: Text("Buy",  style: TextStyle(fontSize: 20),),
        ),
        RaisedButton(
          onPressed: () {},
          color: Colors.green,
          textColor: Colors.white,
          child: Text("Add to Cart",  style: TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}
