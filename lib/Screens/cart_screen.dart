import 'dart:ffi';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lab/Screens/product_list.dart';
import 'package:lab/db_helper.dart';
import 'package:provider/provider.dart';

import '../cart_model.dart';
import '../cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBhelper? dbhelper = DBhelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        actions: [
          Center(
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
          SizedBox(width: 20.0)
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image(
                                        height: 100,
                                        width: 100,
                                        image: NetworkImage(snapshot
                                            .data![index].image
                                            .toString()),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              snapshot.data![index].productName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data![index].productPrice
                                                    .toString() +
                                                "" +
                                                " LKR",
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Align()
                                        ],
                                      )),
                                      SizedBox(
                                        width: 10,
                                        height: 100,
                                      ),
                                      Container(
                                        height: 100,
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.all(20),
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            dbhelper!.delete(
                                                snapshot.data![index].id);
                                            cart.removeCounter();
                                            cart.removerTotalPrice(double.parse(
                                                snapshot
                                                    .data![index].productPrice
                                                    .toString()));
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                          ), //icon data for elevated button
                                          label: Text(
                                            "Remove",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ), //label text
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .red //elevated btton background color
                                              ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ));
                          }));
                }

                return Text('');
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Column(
              children: [
                ReusableWidget(
                    title: 'Sub Total : ',
                    value: r'LKR ' + value.getTotalPrice().toString())
              ],
            );
          })
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
