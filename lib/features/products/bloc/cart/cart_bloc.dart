import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xissors/features/products/data/models/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Map<Product, int> productMap = {};
  CartBloc() : super(const CartLoaded({})) {
    on<AddProduct>((event, emit) => _addProduct(event, emit));
    on<RemoveProduct>((event, emit) => _removeProduct(event, emit));
    on<ClearCart>((event, emit) => _clearCart(event, emit)); 
  }

  _addProduct(AddProduct event, Emitter<CartState> emit) {
    int count = productMap[event.product] ?? 0;
    productMap[event.product] = count++;
    emit(CartLoaded(productMap));
  }

  _removeProduct(RemoveProduct event, Emitter<CartState> emit) {
    int count = productMap[event.product] ?? 0;
    if (count > 0) {
      productMap[event.product] = count--;
    } else {
      productMap.remove(event.product);
    }
    emit(CartLoaded(productMap));
  }
  
  _clearCart(ClearCart event, Emitter<CartState> emit) {
    productMap = {};
    emit(CartLoaded(productMap));
  }
}
