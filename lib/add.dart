import 'package:flutter/material.dart';
import 'database.dart';
import 'model/product.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  int _price = 0;
  String _imageName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm sản phẩm'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tên sản phẩm'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên sản phẩm không được bỏ trống';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Giá'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Giá phải là số nguyên dương';
                    }
                    return null;
                  },
                  onSaved: (value) => _price = int.parse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mô tả'),
                  onSaved: (value) => _description = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tên hình ảnh'),
                  onSaved: (value) => _imageName = value!,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (await DatabaseHelper.instance
                          .checkProductNameExists(_name)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tên sản phẩm đã tồn tại')),
                        );
                        return;
                      }

                      await DatabaseHelper.instance.addProduct(
                        Product(
                          name: _name,
                          description: _description,
                          price: _price,
                          image: _imageName,
                        ),
                      );
                      await DatabaseHelper.instance.getProducts();
                      
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Lưu'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
