import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/product_list.dart';
import 'cart_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          home: const ProductList(),
        );
      }),
    );
  }
}
