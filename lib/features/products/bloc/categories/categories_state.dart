part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState  extends Equatable {}

final class CategoriesInitial extends CategoriesState {@override
  List<Object?> get props => [];}

final class CategoriesLoading extends CategoriesState {@override
  List<Object?> get props => [];}

final class CategoriesSuccess extends CategoriesState {
  final List<String> categories;

  CategoriesSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

final class CategoriesFailure extends CategoriesState {
  final String message;

  CategoriesFailure(this.message);


  @override
  List<Object?> get props => [message];
}