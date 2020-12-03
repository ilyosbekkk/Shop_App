import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/signin_register_modalview.dart';

class Total extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = context.watch<User>();
    double overall = 0;
    List<CartItem> cartItemProducts = cart.items.entries.map((e) => e.value).toList();
    for (CartItem cartItem in cartItemProducts) {
      overall += cartItem.quantity * cartItem.price;
    }
    return Container(
      height: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.only(right: 5),
                child: Text(
                  "Overall: \$${overall}",
                  style: TextStyle(fontSize: 20.0),
                )),
            Container(
              margin: EdgeInsets.only(right: 5),
              child: RaisedButton(
                color: Colors.green,
                onPressed: overall > 0
                    ? () {
                        openSignInModalView(context, user);
                      }
                    : null,
                textColor: Colors.white,
                child: Text("Order now"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void overallPrice(Cart cart, double overall) {}

  void openSignInModalView(BuildContext context, User user) async {
    if (user == null) await showModalBottomSheet(context: context, builder: (context) => SignIn());
    else
    await showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              child: Text(

                "Thank you! Your order has been placed!!!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ));
  }
}
