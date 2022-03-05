import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lab/Screens/cart_screen.dart';
import 'package:lab/cart_model.dart';
import 'package:lab/cart_provider.dart';
import 'package:lab/db_helper.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBhelper dBhelper = DBhelper();
  List<String> productName = [
    'Shoe 1',
    'Shoe 2',
    'Shoe 3',
    'Shoe 4',
  ];
  List<String> productUnit = ['KG', 'Dozen', 'KG', 'DG'];
  List<int> productPrice = [4090, 6990, 7990, 8990];
  List<String> productImage = [
    'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
    'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
    'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
    'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=398&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Store",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              child: Center(
                child: Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(value.getCounter().toString(),
                          style: TextStyle(color: Colors.white));
                    },
                    child: Text(
                      "0",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  badgeColor: Colors.black,
                  animationDuration: Duration(milliseconds: 300),
                  child: Icon(Icons.add_shopping_cart_sharp),
                ),
              ),
            ),
            SizedBox(width: 20.0)
          ],
        ),
        body: GridView.builder(
          itemCount: productImage.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 4.0 / 10.0,
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    productImage[index].toString()),
                                fit: BoxFit.fill),
                          ),
                        )),
                        Center(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                productName[index].toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Center(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                productPrice[index].toString() + "" + " LKR",
                                style: TextStyle(fontSize: 18.0),
                              )),
                        ),
                        Container(
                          height: 100,
                          alignment: Alignment.center,
                          // padding: EdgeInsets.all(20),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              dBhelper
                                  .insert(Cart(
                                      id: index,
                                      productId: index.toString(),
                                      productName:
                                          productName[index].toString(),
                                      initialPrice: productPrice[index],
                                      productPrice: productPrice[index],
                                      quantity: 1,
                                      unitTag: productUnit[index].toString(),
                                      image: productImage[index].toString()))
                                  .then((value) {
                                print('Shoe added to the cart !');
                                cart.addTotalPrice(double.parse(
                                    productPrice[index].toString()));
                                cart.addCounter();
                              }).onError((error, stackTrace) {
                                print(error.toString());
                              });
                            },
                            icon: Icon(Icons
                                .shopping_basket), //icon data for elevated button
                            label: Text("Add to Cart"), //label text
                            style: ElevatedButton.styleFrom(
                                primary: Colors
                                    .grey //elevated btton background color
                                ),
                          ),
                        )
                      ],
                    )));
          },
        ));
  }
}
