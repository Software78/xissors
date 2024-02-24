part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<String> categories;

  CategoriesSuccess(this.categories);
}

final class CategoriesFailure extends CategoriesState {
  final String message;

  CategoriesFailure(this.message);
}