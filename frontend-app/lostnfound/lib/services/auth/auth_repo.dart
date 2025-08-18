import 'package:dio/dio.dart';
import 'package:lostnfound/model/user_model.dart';
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

    final token = res.data as String; // backend returns plain token
    return (user.copyWith(password: ''), token);
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

    final token = res.data as String; // backend returns plain token
    final user = UserModel(
      psid: psid,
      email: '', // not returned by backend, placeholder
      name: '',
      isAdmin: false,
      password: '',
    );

    return (user, token);
  }
}
