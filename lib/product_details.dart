import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String url;
  final double price;
  final String details;
  final String title;
  final int id;
  const ProductDetails({
    Key? key,
    required this.url,
    required this.price,
    required this.details,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      persistentFooterButtons: [
        Text(
          '\$ ${widget.price}',
          style: const TextStyle(
              fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: mq.width * .2,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            color: Colors.green,
            height: mq.height * .05,
            width: mq.width * .4,
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
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                },
                icon: isPressed
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_outline)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mq.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  height: mq.height * .50,
                  child: Image.network(widget.url),
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '\$ ${widget.price}',
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.details,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
