import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lostnfound/model/user_model.dart';

class AppSecureStorage {
  static const _kToken = 'auth_token';
  static const _kUser = 'auth_user';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) =>
      _storage.write(key: _kToken, value: token);
  Future<String?> readToken() => _storage.read(key: _kToken);
  Future<void> deleteToken() => _storage.delete(key: _kToken);

  Future<void> saveUser(UserModel user) =>
      _storage.write(key: _kUser, value: jsonEncode(user.toSafeJson()));
  Future<UserModel?> readUser() async {
    final s = await _storage.read(key: _kUser);
    if (s == null) return null;
    final map = jsonDecode(s) as Map<String, dynamic>;
    return UserModel.fromJson({...map, 'password': ''});
  }

  Future<void> clear() async {
    await _storage.delete(key: _kToken);
    await _storage.delete(key: _kUser);
  }
}
