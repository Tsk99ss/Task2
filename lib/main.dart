import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/provider/provider_detail.dart';
import 'package:task2/screens/cart_screen.dart';
import 'package:task2/screens/dashboard_screen.dart';
import 'package:task2/screens/login_screen.dart';
import 'package:task2/screens/product_detail.dart';
import 'package:task2/screens/splash_screen.dart';

import 'provider/cart_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CartManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: ThemeData(primarySwatch: Colors.orange),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/product-detail': (context) => ProductDetailScreen(),
          '/cart': (context) => CartScreen(),
        },
      ),
    );
  }
}
