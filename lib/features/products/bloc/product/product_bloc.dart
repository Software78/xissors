import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../config/initializer.dart';
import '../../data/models/models.dart';
import '../../data/repository/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late ProductRepository _productRepository;
  ProductBloc() : super(ProductInitial()) {
    _productRepository =
        AppInitializer.instanceLocator.get<ProductRepository>();
    on<ProductLoadEvent>((event, emit) => _loadProducts(event, emit));
  }

  _loadProducts(ProductLoadEvent event, Emitter<ProductState> emit) async {
    final response = await _productRepository.getProducts();
    if (response.isSuccess) {
      emit(ProductSuccess(response.data as List<Product>));
    } else {
      emit(ProductFailure(response.message ?? 'An error occurred'));
    }
  }
}
