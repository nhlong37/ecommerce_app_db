import 'package:ecommerce_app/addedit.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() async {
    final products = await _dbHelper.getProducts();
    setState(() {
      _products = products;
    });
  }

  void _deleteProduct(int id) async {
    await _dbHelper.deleteProduct(id);
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
          return ListTile(
            leading: Image.asset(product['image']),
            title: Text(product['name']),
            subtitle: Text(product['description']),
            trailing: Text('\$${product['price']}'),
            onTap: () => Navigator.pushNamed(
              context,
              '/detail',
              arguments: product,
            ),
            onLongPress: () => _deleteProduct(product['id']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
