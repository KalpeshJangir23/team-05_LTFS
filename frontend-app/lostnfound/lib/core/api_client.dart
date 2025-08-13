import 'package:dio/dio.dart';
import 'secure_storage.dart';

class ApiClient {
  final Dio dio;
  final AppSecureStorage storage;

  ApiClient({required String baseUrl, required this.storage})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        )) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (opts, handler) async {
      final token = await storage.readToken();
      if (token != null && token.isNotEmpty) {
        opts.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(opts);
    }));
  }
}
