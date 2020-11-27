import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return _items;
  }

  Products(){
    List<Product> products = new List();
   products.add(Product(id: "d", title: "df", description: "fvf", price: 12.3, isFavorite: false));
   print(products[0].title);
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        _items.add(Product(
              id: doc['id'],
              title: doc['title'],
              description: doc['description'],
              price: doc['price'],
              imageUrl: doc['imageUrl'],
              isFavorite: doc['isFavorite']));
        notifyListeners();
      })
    });
  }


  List<Product> get favorites {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }
}


