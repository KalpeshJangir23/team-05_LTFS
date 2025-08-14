import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lostnfound/provider/auth_provider.dart';
import 'secure_storage.dart';

class ApiClient {
  final Dio dio;
  final AppSecureStorage storage;

  ApiClient({required String baseUrl, required this.storage})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(minutes: 2), // 2 minutes
          sendTimeout: const Duration(minutes: 10),
          receiveTimeout: const Duration(minutes: 10),
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

// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.read(storageProvider);
  return ApiClient(baseUrl: 'http://192.168.102.130:8080/', storage: storage);
});
