import '../../../../core/network/api_client.dart';

abstract class AuthRepository {
  Future<ApiResponse> login();
}
