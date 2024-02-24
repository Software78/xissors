abstract class ApiClient {
  void setToken(String token);
  void removeToken();
  Future<ApiResponse<T>> request<T>(
    String path, {
    required MethodType method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic> json)? fromJson,
  });
}

enum MethodType { get, post, put, delete, patch }

class ApiResponse<T extends Object?> {
  final String? message;

  final T? data;
  final bool isSuccess;

  ApiResponse({
    this.message,
    this.data,
    required this.isSuccess,
  });

  @override
  String toString() {
    return 'ApiResponse<$T>{message: $message, data: $data}';
  }

  factory ApiResponse.error({String? message}) {
    return ApiResponse<T>(
      message: message ?? 'Something went wrong',
      isSuccess: false,
    );
  }
}
