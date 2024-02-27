part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  List<Product> filteredProducts(String category) => [];
  Product getProductByName(String name) => const Product();
}

final class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

final class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

final class ProductSuccess extends ProductState {
  final List<Product> products;

  ProductSuccess(this.products);

  @override
  List<Object?> get props => [products];

  @override
  List<Product> filteredProducts(String category) {
    return products.where((element) => element.category == category).toList();
  }

  @override
  Product getProductByName(String name) {
    return products.firstWhere((element) => element.name == name);
  }
}

final class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);

  @override
  List<Object?> get props => [
        message,
      ];
}
