import 'package:flutter/foundation.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart'; // Import your CartItem model

class CartManager with ChangeNotifier {
  List<CartItem> cartItems = []; // List of cart items

  // Method to add product to cart
  void addToCart(Product product) {
    for (var item in cartItems) {
      if (item.product.id == product.id) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    // If not, add new item to cart
    cartItems.add(CartItem(product: product));
    notifyListeners();
  }

  // Method to increase quantity
  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  // Method to decrease quantity
  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.remove(item); // Remove item if quantity is 0
    }
    notifyListeners();
  }

  // Calculate total price
  double get totalPrice {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
