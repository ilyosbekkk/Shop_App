import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class Total extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    double overall = 0;
   List<CartItem> cartItemProducts =  cart.items.entries.map((e) => e.value).toList();
   for(CartItem cartItem in cartItemProducts){
     overall+=cartItem.quantity * cartItem.price;
   }
    return Container(
      height: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: EdgeInsets.only(right: 5), child: Text("Overall: \$${overall}",  style: TextStyle(
              fontSize: 20.0
            ),)),
            Container(
              margin: EdgeInsets.only(right: 5),
              child: RaisedButton(
                color: Colors.green,
                onPressed: () {},
                textColor: Colors.white,
                child: Text("Order now"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
