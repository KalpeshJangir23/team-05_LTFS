import 'package:dio/dio.dart';
import 'package:lostnfound/model/user_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../core/api_client.dart';

class AuthRepository {
  final ApiClient client;
  AuthRepository(this.client);

  // POST /signup -> expects psid, email, password, name
  Future<(UserModel, String)> signUp(UserModel user) async {
    final payload = {
      'psid': user.psid,
      'email': user.email,
      'password': user.password,
      'name': user.name,
    };

    final res = await client.dio.post(
      'auth/register',
      data: FormData.fromMap(payload),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final token = res.data as String;

    final newUser = userFromToken(token);

    return (newUser, token);
  }

  // POST /login -> expects psid, password
  Future<(UserModel, String)> login({
    required String psid,
    required String password,
  }) async {
    final payload = {
      'psid': psid,
      'password': password,
    };

    final res = await client.dio.post(
      'auth/login',
      data: FormData.fromMap(payload),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final token = res.data as String;

    final user = userFromToken(token);

    return (user, token);
  }
}

UserModel userFromToken(String token) {
  final Map<String, dynamic> decoded = JwtDecoder.decode(token);

  return UserModel(
    psid: decoded['psid']?.toString() ?? '',
    email: decoded['email']?.toString() ?? '',
    name: decoded['name']?.toString() ?? '',
    isAdmin: decoded['isAdmin'] == true || decoded['isAdmin'] == 1,
    password: '', // never store password in memory
  );
}
