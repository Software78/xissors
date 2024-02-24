import 'package:get_it/get_it.dart';
import 'package:xissors/config/initializer.dart';
import 'package:xissors/core/network/api_client.dart';
import 'package:xissors/features/auth/data/respository/auth_repository.dart';
import 'package:xissors/features/products/data/models/models.dart';
import 'package:xissors/features/products/data/repository/product_repo.dart';

final mockCategories = ['feet', 'hair', 'face'];

final mockProducts = [
  const Product(
    name: 'Product 1',
    price: 100,
    category: 'feet',
  ),
  const Product(
    name: 'Product 2',
    price: 200,
    category: 'hair',
  ),
  const Product(
    name: 'Product 3',
    price: 300,
    category: 'face',
  ),
];

class MockProductRepo implements ProductRepository {
  @override
  Future<ApiResponse<List<Product>>> getProducts() async {
    return Future.value(ApiResponse(data: mockProducts, isSuccess: true));
  }

  @override
  Future<ApiResponse<List<String>>> getCategories() async {
    return Future.value(ApiResponse(data: mockCategories, isSuccess: true));
  }
}

class MockAuthRepository extends AuthRepository {
  @override
  Future<ApiResponse> login() {
    return Future.value(ApiResponse(isSuccess: true));
  }
}

class MockAppInitializer extends AppInitializer {
  static late GetIt instanceLocator;

  static void init() {
    instanceLocator = GetIt.instance;
    initialize();
  }

  static void initialize() {
    // initializeNavigator();
    // initializeRemoteDataSources();
    initializeRepo();
  }

  // @override
  static void initializeRepo() {
    instanceLocator.registerLazySingleton<ProductRepository>(
      () => MockProductRepo(),
    );
    instanceLocator.registerLazySingleton<AuthRepository>(
      () => MockAuthRepository(),
    );
  }
}
