import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item_model.dart';
import '../provider/cart_manager.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          title: const Text(
            "Cart",
            style: TextStyle(color: Colors.white),
          )),
      body: Consumer<CartManager>(
        // Use a state management solution
        builder: (context, cartManager, child) {
          if (cartManager.cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty."));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartManager.cartItems.length,
                  itemBuilder: (context, index) {
                    CartItem cartItem = cartManager.cartItems[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Product Image
                            Image.network(cartItem.product.image,
                                width: 50, height: 50),
                            const SizedBox(width: 10),
                            // Product Title
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItem.product.title),
                                  Text('\$${cartItem.product.price}'),
                                ],
                              ),
                            ),
                            // Quantity Control
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    cartManager.decreaseQuantity(cartItem);
                                  },
                                ),
                                Center(
                                  child: Text(
                                    '${cartItem.quantity}',
                                    // Display the quantity
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    cartManager.increaseQuantity(cartItem);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Total Price
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:", style: TextStyle(fontSize: 20)),
                    Text(
                        "\$${cartManager.totalPrice.toString().substring(0, 3)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Checkout functionality can be added here
                },
                child: const Text("Checkout"),
              ),
            ],
          );
        },
      ),
    );
  }
}
