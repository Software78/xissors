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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'category': category,
    };
  }

  Product copyWith(
      {String? name,
      String? image,
      double? price,
      int? quantity,
      String? category}) {
    return Product(
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category);
  }

  @override
  String toString() {
    return 'Product(name: $name, image: $image, price: $price, quantity: $quantity, category: $category)';
  }

  @override
  List<Object?> get props => [name, image, price, quantity, category];
}

// {
//             "name": "blissful skin",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXsTmAd4oIeJeW-cf1yJDB-jNIMlAs0kXC0g&usqp=CAU",
//             "price": 100,
//             "quantity": 2,
//             "category": "skin"
//         }