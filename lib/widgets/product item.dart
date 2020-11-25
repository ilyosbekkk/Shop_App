import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'file:///D:/Flutter%20Projects/shop_app/lib/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';



class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

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
            trailing: shoppingChart(item, cart, context),
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

  Widget shoppingChart(Product item, Cart cart, BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        cart.updateItems(item.id, item.price, item.title, item.imageUrl, "+");
        /*Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Your cart has changed!"),
            action: SnackBarAction(
              label: "Undo",
              textColor: Colors.blue,
              onPressed: () {
                cart.updateItems(item.id, item.price, item.title, item.imageUrl, "-");
                Consumer<Cart>(
                  builder: (context, cart,  child) => Badge(child: child, value: cart.items.length.toString()),
                );
              },
            )));*/
      },
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
