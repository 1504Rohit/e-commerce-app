import 'package:flutter/material.dart';

import 'model.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  static List<Products> item = [];
  static addData(Products data) {
    if (item.contains(data) == false) {
      item.add(data);
    }
  }

  static int getItem() {
    return item.length;
  }

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double sum = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < CartPage.item.length; i++) {
      sum += CartPage.item[i].price;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        persistentFooterButtons: [
          Text(
            'Total Price is: \$ ${sum.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: mq.width * .03,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              color: Colors.green,
              height: mq.height * .05,
              width: mq.width * .3,
              child: const Center(
                child: Text(
                  'Buy Now',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.shopping_cart,
              size: 40,
              color: Colors.blue,
            ),
          ),
          title: const Text(
            'Your Cart Items',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
            itemCount: CartPage.item.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.network(CartPage.item[index].image),
                  title: Text('\$ ${CartPage.item[index].price}'),
                  subtitle: Text(CartPage.item[index].title),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          sum = sum - CartPage.item[index].price;
                          CartPage.item.remove(CartPage.item[index]);
                        });
                      },
                      icon: const Icon(Icons.delete)),
                ),
              );
            }));
  }
}
