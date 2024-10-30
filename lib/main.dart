import 'package:ecommerce_app/addedit.dart';
import 'package:ecommerce_app/detail.dart';
import 'package:ecommerce_app/home.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      // initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/add': (context) => AddEditScreen(),
        '/edit': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return AddEditScreen(product: product);
        },
        '/detail': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return DetailScreen(product: product);
        },
      },
    );
  }
}
