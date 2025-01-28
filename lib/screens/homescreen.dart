import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylecart/providers/providerrr.dart';
import '../model classes/cartmodel.dart';
import '../providers/cartprovider.dart';
import 'carts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<ProductProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "StyleCart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (productProvider.products.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            return SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  final product = productProvider.products[index];
                  final imageUrl = product['image'];
                  final name = product['title'];
                  final price = product['price'];
              
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "DetailPage",arguments: {
                          "Image": imageUrl,
                          "Name": name,
                          "Price": price.toString()
                        });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                imageUrl,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  '\$$price',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  final cartItem = CartItem(name: name, price: price);
                                  Provider.of<CartProvider>(context, listen: false)
                                      .addToCart(cartItem,context);
                                },
                              child: Text(
                                "Add to cart",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xfff3520a),
                                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                                shape: BeveledRectangleBorder(),
                              ),
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
