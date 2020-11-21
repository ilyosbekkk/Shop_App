import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/total.dart';

class CartScreen extends StatelessWidget {
  static String routName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartProducts = Provider.of<Cart>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("Hello");

    List<CartItem> cartProduct =
        cartProducts.items.entries.map((e) => e.value).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart  Screen"),
        ),
        body: Column(
          children: [
            Total(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,

                itemCount: cartProduct.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: cartProduct[index],
                  child: MyCart(
                    height: height,
                    width: width,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
