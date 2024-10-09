import 'product_model.dart'; // Ensure you import your Product model

// Updated CartItem model
class CartItem {
  final Product product; // Product object instead of separate fields
  int quantity; // Quantity of the product

  CartItem({
    required this.product,
    this.quantity = 1, // Default quantity is 1
  });
}
