import 'package:xissors/core/network/api_client.dart';
import 'package:xissors/features/products/data/models/models.dart';

import 'product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient _apiClient;

  ProductRepositoryImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<ApiResponse<List<String>>> getCategories() {
    return _apiClient.request(
      '/categories',
      method: MethodType.get,
      fromJson: (json) {
        return (json['data'] as List).map((e) => e as String).toList();
      },
    );
  }

  @override
  Future<ApiResponse<List<Product>>> getProducts() {
    return _apiClient.request(
      '/products',
      method: MethodType.get,
      fromJson: (json) {
        return (json['data'] as List).map((e) => Product.fromJson(e)).toList();
      },
    );
  }
}
