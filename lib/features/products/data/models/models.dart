class Product {
  final String name;
  final String image;
  final double price;
  final int quantity;
  final String category;

  Product(
      {required this.name,
      required this.image,
      required this.price,
      required this.quantity,
      required this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        image: json['image'],
        price: json['price'],
        quantity: json['quantity'],
        category: json['category']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'category': category
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.image == image &&
        other.price == price &&
        other.quantity == quantity &&
        other.category == category;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        category.hashCode;
  }
}

// {
//             "name": "blissful skin",
//             "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXsTmAd4oIeJeW-cf1yJDB-jNIMlAs0kXC0g&usqp=CAU",
//             "price": 100,
//             "quantity": 2,
//             "category": "skin"
//         }