import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:xissors/features/products/data/repository/product_repo.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  late ProductRepository productRepository;
  CategoriesBloc(this.productRepository) : super(CategoriesInitial()) {
    
    on<CategoriesLoadEvent>((event, emit) => _loadCategories(event, emit));
  }

  _loadCategories(
      CategoriesLoadEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    final response = await productRepository.getCategories();
    if (response.isSuccess) {
      emit(CategoriesSuccess(response.data as List<String>));
    } else {
      emit(CategoriesFailure(response.message ?? 'An error occurred'));
    }
  }
}
