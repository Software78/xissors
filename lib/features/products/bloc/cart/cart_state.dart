part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];

  Map<Product, int> get products => {};
}

final class CartLoaded extends CartState {
  final Map<Product, int> productMap;

  const CartLoaded(this.productMap);

  @override
  List<Object> get props => [productMap];

  @override
  Map<Product, int> get products => productMap;
}

final class CartLoading extends CartState{}