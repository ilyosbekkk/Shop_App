import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class MyCart extends StatelessWidget {
  final height;
  final width;

  const MyCart({this.height, this.width});

  //region overrides
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<CartItem>(context);
    final cart = Provider.of<Cart>(context);
    return Container(
        width: double.infinity,
        height: height * .25,
        child: cardItemBuilder(product, cart));
  }

  //endregion
  //region utlity methods
  void updateCartItem(String sign, Cart cart, CartItem product) {
    cart.updateItems(
        product.id, product.price, product.title, product.imageUrl, sign);
  }

  //endregion
  //region UI builders
  Widget cardItemBuilder(CartItem product, Cart cart) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          networkImage(product),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    bottom: 10,
                    top: 10),
                child: Text(
                  product.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ),
              priceBox(product),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconButtons(Icons.remove, cart, product),
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.1,
                    height: width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      product.quantity.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  iconButtons(Icons.add, cart, product),
                  iconButtons(Icons.delete_outline, cart, product),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget iconButtons(IconData icon, Cart cart, CartItem product) {
    return IconButton(
        icon: Icon(icon),
        onPressed: () {
          if (icon == Icons.add)
            updateCartItem("+", cart, product);
          else if (icon == Icons.remove)
            updateCartItem("-", cart, product);
          else
            updateCartItem("deleter", cart, product);
        });
  }

  Widget priceBox(CartItem product) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: width * 0.5,
      decoration: BoxDecoration(
          color: Colors.black12, border: Border.all(color: Colors.white)),
      child: Text(
        "\$${product.price}(${product.quantity})",
        textAlign: TextAlign.center,
      ),
    );
  }
  Widget networkImage(CartItem product) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green)),
      alignment: Alignment.center,
      width: width * 0.3,
      height: height * 0.15,
      child: Image.network(product.imageUrl),
    );
  }
//endregion
}
