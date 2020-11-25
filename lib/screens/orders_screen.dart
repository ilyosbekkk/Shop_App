import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/drawer.dart';

class MyOrders extends StatefulWidget {
  static String routeName = "/my_orders";

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    double overall = 0;
    List<CartItem> cartItemProducts =
        cart.items.entries.map((e) => e.value).toList();
    for (CartItem cartItem in cartItemProducts) {
      overall += cartItem.quantity * cartItem.price;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: Container(child: overallOrderSummary(overall, cartItemProducts)),
      drawer: DrawerWidget(),
    );
  }

  Widget overallOrderSummary(double overall, List<CartItem> products) {
    return Column(
      children: [
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total: \$${overall}"),
              IconButton(
                  icon: expanded
                      ? Icon(
                          Icons.expand_less,
                        )
                      : Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  })
            ],
          ),
        ),
        if (expanded) itemList(products),
        Text(
          "Status:Delivered",
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget itemList(List<CartItem> products) {
    return Card(
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(products[index].title),
                subtitle: Text("\$${products[index].price.toString()}"),
                trailing: Text("${products[index].quantity}"));
          }),
    );
  }
}
