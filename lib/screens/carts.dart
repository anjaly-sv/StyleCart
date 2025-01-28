import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cartprovider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return cartProvider.cartItems.isEmpty
                ? Center(child: Text("Your cart is empty"))
                : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartProvider.cartItems[index];
                return ListTile(
                  title: Text(cartItem.name),
                  subtitle: Text("\$${cartItem.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      cartProvider.removeFromCart(cartItem,context);
                    },
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: \$${cartProvider.totalPrice}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Successfully Placed'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text("Checkout"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
