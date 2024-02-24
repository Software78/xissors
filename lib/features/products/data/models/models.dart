import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? name;
  final String? image;
  final double? price;
  final int? quantity;
  final String? category;

  const Product({
    this.name,
    this.image,
    this.price,
    this.quantity,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['category'],
    );
  }

  @override
  String toString() {
    return 'Product(name: $name, image: $image, price: $price, quantity: $quantity, category: $category)';
  }

  @override
  List<Object?> get props => [name, image, price, quantity, category];
}