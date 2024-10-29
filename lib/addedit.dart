import 'package:flutter/material.dart';
import 'database.dart';

class AddEditScreen extends StatefulWidget {
  final Map<String, dynamic>? product;

  AddEditScreen({this.product});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dbHelper = DatabaseHelper();
  String _name = '';
  String _description = '';
  int _price = 0;
  String _image = '';

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!['name'];
      _description = widget.product!['description'];
      _price = widget.product!['price'];
      _image = widget.product!['image'];
    }
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = {
        'name': _name,
        'description': _description,
        'price': _price,
        'image': _image,
      };

      if (widget.product == null) {
        await _dbHelper.insertProduct(product);
      } else {
        await _dbHelper.updateProduct(widget.product!['id'], product);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter a name';
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              initialValue: _description,
              decoration: InputDecoration(labelText: 'Description'),
              onSaved: (value) => _description = value!,
            ),
            TextFormField(
              initialValue: _price.toString(),
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) {
                final price = int.tryParse(value ?? '');
                if (price == null || price <= 0) return 'Enter a positive integer';
                return null;
              },
              onSaved: (value) => _price = int.parse(value!),
            ),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text(widget.product == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
