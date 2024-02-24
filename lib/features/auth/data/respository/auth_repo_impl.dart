
import '../../../../core/network/api_client.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<ApiResponse> login({required String email, required String password}) {
    
    return _apiClient.request(
      '/log_in',
      method: MethodType.post,
      payload: {
        'email': email,
        'password': password,}
    );
  }
}
