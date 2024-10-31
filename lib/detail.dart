import 'update.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'model/product.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatelessWidget {
  var formartPrice = NumberFormat('#,##0 vnđ', 'vi');

  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Column(
          children: [
            Image.asset('images/${product.image}'),
            Text(product.name, style: TextStyle(fontSize: 24)),
            Text('${formartPrice.format(product.price)}', style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Sửa'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProductPage(product: product),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Xóa'),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Xóa sản phẩm'),
                        content: Text('Bạn có chắc chắn muốn xóa sản phẩm này không?'),
                        actions: [
                          TextButton(
                            child: Text('Hủy'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            child: Text('Xóa'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      ),
                    );
                    if (confirm ?? false) {
                      await DatabaseHelper.instance.deleteProduct(product.id!);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
