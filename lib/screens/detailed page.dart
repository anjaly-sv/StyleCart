import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model classes/cartmodel.dart';
import '../providers/cartprovider.dart';

class DetailedPage extends StatelessWidget {
  const DetailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final imageurl = args?["Image"];
    final name = args?["Name"];
    final price = args?["Price"];
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.5,
                    image: NetworkImage(imageurl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff2f3d4e),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon:
                              Icon(Icons.arrow_back_ios_new_outlined, size: 15),
                          color: Colors.white,
                        ),
                      ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffb5d0a6),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(price,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        //height: 100,
        child: ElevatedButton(
            onPressed: () {
              double parsedPrice = double.tryParse(price) ?? 0.0;
              final cartItem = CartItem(name: name, price: parsedPrice);

              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(cartItem,context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfff3520a),
                ),
            child: Text("Add to cart",
                style: TextStyle(fontSize: 18, color: Colors.white)))
      ),
    );
  }
}
