import 'package:dio/dio.dart';
import 'package:lostnfound/model/user_model.dart';
import '../../core/api_client.dart';

class AuthRepository {
  final ApiClient client;
  AuthRepository(this.client);

  // POST /signup -> expects full user payload, returns { user, token }
  Future<(UserModel, String)> signUp(UserModel user) async {
    final res = await client.dio.post('signup', data: user.toJson());
    final data = res.data as Map<String, dynamic>;
    final u = UserModel.fromJson({...data['user'], 'password': ''});
    final token = data['token'] as String;
    return (u, token);
  }

  // POST /login -> expects { psid, password }, returns { user, token }
  Future<(UserModel, String)> login(
      {required String psid, required String password}) async {
    final res = await client.dio
        .post('login', data: {'psid': psid, 'password': password});
    final data = res.data as Map<String, dynamic>;
    final u = UserModel.fromJson({...data['user'], 'password': ''});
    final token = data['token'] as String;
    return (u, token);
  }
}
