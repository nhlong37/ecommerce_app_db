import 'package:flutter/material.dart';
import 'database.dart';
import 'model/product.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late int _price;
  late String _imageName;

  @override
  void initState() {
    super.initState();
    // Gán giá trị ban đầu từ sản phẩm hiện tại
    _name = widget.product.name;
    _description = widget.product.description;
    _price = widget.product.price;
    _imageName = widget.product.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sửa sản phẩm')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
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
                initialValue: _price.toString(),
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
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Mô tả'),
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _imageName,
                decoration: InputDecoration(labelText: 'URL hình ảnh'),
                onSaved: (value) => _imageName = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Kiểm tra trùng tên
                    if (await DatabaseHelper.instance
                        .checkProductNameExists(_name)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tên sản phẩm đã tồn tại')),
                      );
                      return;
                    }

                    // Cập nhật sản phẩm
                    final updatedProduct = Product(
                      id: widget.product.id,
                      name: _name,
                      description: _description,
                      price: _price,
                      image: _imageName,
                    );
                    await DatabaseHelper.instance.updateProduct(updatedProduct);
                    Navigator.pop(context);
                  }
                },
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
