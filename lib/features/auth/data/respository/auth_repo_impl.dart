
import '../../../../core/network/api_client.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<ApiResponse> login() {
    
    return _apiClient.request(
      '/login',
      method: MethodType.post,
    );
  }
}
