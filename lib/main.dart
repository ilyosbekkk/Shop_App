import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/products overview screen.dart';
import 'screens/product_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverview(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen()
        },
      ),
    );
  }
}
