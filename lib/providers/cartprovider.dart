import 'package:flutter/material.dart';
import '../model classes/cartmodel.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item,context) {
    _cartItems.add(item);
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void removeFromCart(CartItem item,context) {
    _cartItems.remove(item);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} removed from cart!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }
}
