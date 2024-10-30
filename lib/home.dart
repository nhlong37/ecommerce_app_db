import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _db = DatabaseHelper();
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    final products = await _db.getProducts();
    setState(() {
      _products = products;
    });
  }

  void _deleteProduct(int id) async {
    await _db.deleteProduct(id);
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/detail', arguments: product),
              child: Card(
                child: Column(children: [
                  Image.asset('images/${product['image']}'),
                  SizedBox(height: 15),
                  Text(product['name']),
                  SizedBox(height: 15),
                  Text(product['description']),
                  SizedBox(height: 15),
                  Text('Price: ${product['price']}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: product,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteProduct(product['id']),
                      ),
                    ],
                  )
                ]),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: Icon(Icons.add),
      ),
    );
  }
}
