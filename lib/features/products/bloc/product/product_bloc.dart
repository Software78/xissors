import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/models.dart';
import '../../data/repository/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<ProductLoadEvent>((event, emit) => _loadProducts(event, emit));
  }

  _loadProducts(ProductLoadEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final response = await productRepository.getProducts();
    if (response.isSuccess) {
      emit(ProductSuccess(response.data as List<Product>));
    } else {
      emit(ProductFailure(response.message ?? 'An error occurred'));
    }
  }
}
