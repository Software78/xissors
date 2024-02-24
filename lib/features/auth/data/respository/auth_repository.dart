import '../../../../core/network/api_client.dart';

abstract class AuthRepository {
  Future<ApiResponse> login({required String email, required String password});
}
