import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xissors/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:xissors/features/auth/data/respository/auth_repository.dart';
import 'package:xissors/features/products/bloc/categories/categories_bloc.dart';
import 'package:xissors/features/products/bloc/product/product_bloc.dart';
import 'package:xissors/features/products/data/repository/product_repo.dart';

import 'mock_data.dart';

void main() async {
  MockAppInitializer.init();
  
  group('product bloc test', () {
    late ProductRepository mockProductRepo;
    late ProductBloc productBloc;
    setUp(() {
      mockProductRepo =
          MockAppInitializer.instanceLocator.get<ProductRepository>();
      productBloc = ProductBloc(mockProductRepo);
    });
    blocTest(
      'Emits [ProductLoading, ProductSuccess] when ProductLoadEvent is added.',
      build: () => productBloc,
      act: (bloc) => bloc.add(ProductLoadEvent()),
      expect: () => [
        ProductLoading(),
        ProductSuccess(mockProducts),
      ],
    );
    tearDown(() => productBloc.close());
  });

  group('categories bloc test', () {
    late ProductRepository mockProductRepo;
    late CategoriesBloc categoriesBloc;
    setUp(() {
      mockProductRepo =
          MockAppInitializer.instanceLocator.get<ProductRepository>();
      categoriesBloc = CategoriesBloc(mockProductRepo);
    });
    blocTest(
      'Emits [CategoriesLoading, CategoriesSuccess] when CategoriesLoadEvent is added.',
      build: () => categoriesBloc,
      act: (bloc) => bloc.add(CategoriesLoadEvent()),
      expect: () => [
        CategoriesLoading(),
        CategoriesSuccess(mockCategories),
      ],
    );
    tearDown(() => categoriesBloc.close());
  });

  group('auth bloc test', () {
    late AuthRepository mockAuthRepo;
    late AuthBloc authBloc;
    setUp(() {
      mockAuthRepo = MockAppInitializer.instanceLocator.get<AuthRepository>();
      authBloc = AuthBloc(mockAuthRepo);
    });
    blocTest(
      'Emits [AuthLoading, AuthSuccess] when AuthLoginEvent is added.',
      build: () => authBloc,
      act: (bloc) => bloc.add(AuthLoginEvent(email: '', password: '')),
      expect: () => [
        AuthLoading(),
        AuthSuccess('success', true),
      ],
    );
  });
}
