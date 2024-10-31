// product.dart

class Product {
  final int? id;
  final String name;
  final String description;
  final int price;
  final String image;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  // Chuyển từ Map sang đối tượng Product
  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
      );

  // Chuyển từ đối tượng Product sang Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}
