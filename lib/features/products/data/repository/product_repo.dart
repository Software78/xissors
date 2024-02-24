import 'package:xissors/core/network/api_client.dart';

import '../models/models.dart';

abstract class ProductRepository{
  Future<ApiResponse<List<Product>>> getProducts();
  Future<ApiResponse<List<String>>> getCategories();
}