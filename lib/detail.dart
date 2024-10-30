import 'package:flutter/material.dart';
import 'database.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  DetailScreen({required this.product});

  void _deleteProduct(BuildContext context, int id) async {
    await _dbHelper.deleteProduct(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'])),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 40, 32, 44),
        child: Column(
          children: [
            Image.asset('images/${product['image']}'),
            Text(product['description']),
            Text('Price: ${product['price']}'),
            ElevatedButton(
              onPressed: () => _deleteProduct(context, product['id']),
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/edit',
                arguments: product,
              ),
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
