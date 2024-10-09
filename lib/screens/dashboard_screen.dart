import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:task2/screens/product_detail.dart';
import 'dart:convert';
import '../models/category_model.dart';
import '../models/product_model.dart';
import 'cart_screen.dart';
import 'category_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Category> categories = [];
  List<Product> products = [];
  bool isLoading = true; // Loading state variable

  final List<String> imgList = [
    'https://via.placeholder.com/400x200.png?text=Image+1',
    'https://via.placeholder.com/400x200.png?text=Image+2',
    'https://via.placeholder.com/400x200.png?text=Image+3',
    'https://via.placeholder.com/400x200.png?text=Image+4',
    'https://via.placeholder.com/400x200.png?text=Image+5',
    'https://via.placeholder.com/400x200.png?text=Image+6',
  ];

  final List<String> categoryLogo = [
    "https://via.placeholder.com/400x200.png?text=Electronics",
    "https://via.placeholder.com/400x200.png?text=Jewelry",
    "https://via.placeholder.com/400x200.png?text=Men's+Clothing",
    "https://via.placeholder.com/400x200.png?text=Women's+Clothing"
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      fetchCategories();
      fetchProducts();
    });
  }

  Future<void> fetchCategories() async {
    try {
      final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
      if (response.statusCode == 200) {
        List<String> data = List<String>.from(json.decode(response.body));
        setState(() {
          for (int i = 0; i < data.length; i++) {
            categories.add(Category(name: data[i], image: categoryLogo[i]));
          }
          isLoading = false; // Update loading state
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load categories')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching categories')),
      );
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          products = data.map((json) => Product.fromJson(json)).toList();
        });
      } else {
        print('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "E-Commerce",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Navigate to CartScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(), // Loading spinner
      )
          : SingleChildScrollView(
        // Makes the entire page scrollable
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
              ),
              items: products
                  .map((item) => Center(
                child: Image.network(item.image ?? '',
                    fit: BoxFit.contain, width: 1000),
              ))
                  .toList(),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductScreen(category: categories[index].name),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10.0),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                            NetworkImage(categories[index].image ?? ''),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 60.0,
                            child: Text(
                              categories[index].name ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Featured Products",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // Ensures the grid view doesn't take infinite space
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: products[index]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(products[index].image ?? ''),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  products[index].title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '\$${products[index].price.toString()}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
