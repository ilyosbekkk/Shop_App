import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/products%20overview%20screen.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/total.dart';

class CartScreen extends StatelessWidget {
  static String routName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartProducts = Provider.of<Cart>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<CartItem> cartProduct =
        cartProducts.items.entries.map((e) => e.value).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart  Screen"),
        ),
        body: cartProduct.length > 0
            ? Column(
                children: [
                  Total(),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartProduct.length,
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                        value: cartProduct[index],
                        child: MyCart(
                          height: height,
                          width: width,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : emptyCart(context));
  }

  Widget emptyCart(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text("Your Cart is emtpty", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 25
            ),),
          ),
          Container(
            child: RaisedButton(
              child: Text("Shop now!"),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, ProductsOverview.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
