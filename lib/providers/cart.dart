import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem(
      {@required this.imageUrl,
      @required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void updateItems(String productId, double price, String title,
      String imageUrl, String sign) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                imageUrl: existingCartItem.imageUrl,
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: sign == "+"
                    ? existingCartItem.quantity + 1
                    : existingCartItem.quantity - 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              imageUrl: imageUrl,
              id: productId,
              title: title,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }
}
