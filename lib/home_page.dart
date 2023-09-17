import 'dart:convert';
import 'package:e_commerce/cart_page.dart';
import 'package:e_commerce/model.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/product_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Products> list = [];

  List<String> list1 = [
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/sale-online-shopping-happy-women-laptop-ad-design-template-f3105dbab18d7928bd098387718750ad_screen.jpg?ts=1605596403',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/weekend-sale-social-media-post-template-design-278642e6d29de142b4cf6ef588be45dc_screen.jpg?ts=1584716866',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/flash-sale-design-template-6ef8eb34f4332ea3c3bc54e17cd64eb9_screen.jpg?ts=1685944106',
  ];
  bool isPressed = false;

  int item = 0;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: isPressed
            ? const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintMaxLines: 1,
                ),
              )
            : const Text(
                'GlobalCart',
                style: TextStyle(color: Colors.black),
              ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isPressed = !isPressed;
                });
              },
              icon: isPressed
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search_outlined)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartPage()));
              },
              icon: CartPage.getItem() == 0
                  ? const Icon(Icons.shopping_cart)
                  : badges.Badge(
                      badgeContent: Text('${CartPage.getItem()}'),
                      child: const Icon(Icons.shopping_cart),
                    )),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt)),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: mq.height * .30,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'rohitgiri945@gmail.com',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 20),
              child: Column(children: [
                Card(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        color: Colors.black,
                      ),
                      Text(
                        'Your Order',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: mq.height * .2,
            width: mq.width,
            child: Swiper(
              autoplay: true,
              itemWidth: mq.width,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  list1[index],
                  fit: BoxFit.cover,
                );
              },
              pagination: SwiperPagination(),
              control: SwiperControl(),
            ),
          ),
          Container(
            height: mq.height * .69,
            width: mq.width,
            child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount: list.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 6.0),
                      itemBuilder: (BuildContext context, int index) {
                        return CardView(
                            context,
                            list[index].image,
                            list[index].price,
                            list[index].description,
                            list[index].title,
                            list[index].id);
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget CardView(BuildContext context, String url, double price,
      String details, String title, int id) {
    final mq = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetails(
                    url: url,
                    price: price,
                    details: details,
                    title: title,
                    id: id)));
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.blue.shade300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: mq.height * .10,
                    width: mq.width * .5,
                    child: Image.network(url)),
                Text('\$ ${price}'),
                Text(
                  title,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          CartPage.addData(Products(
                              id: id,
                              title: title,
                              price: price,
                              description: details,
                              category: 'null',
                              image: url));
                          setState(() {
                            item = CartPage.getItem();
                          });
                          const snackBar = SnackBar(
                            padding: EdgeInsets.all(20),
                            elevation: 4,
                            backgroundColor: Colors.blue,
                            content: Text('Sucessfully Added To Your Cart'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text('Add to Cart')),
                  ],
                )
              ]),
        ),
      ),
    );
  }

  Future<List<Products>?> getData() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        list.add(Products.fromJson(index));
      }
      return list;
    }

    return list;
  }
}
