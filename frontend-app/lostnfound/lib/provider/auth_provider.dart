import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lostnfound/model/user_model.dart';
import 'package:lostnfound/services/auth/auth_repo.dart';
import '../../core/secure_storage.dart';
import '../../core/api_client.dart';

class AuthState {
  final UserModel? user;
  final String? token;
  final bool loading;
  final String? error;

  const AuthState({this.user, this.token, this.loading = false, this.error});

  AuthState copyWith(
          {UserModel? user, String? token, bool? loading, String? error}) =>
      AuthState(
        user: user ?? this.user,
        token: token ?? this.token,
        loading: loading ?? this.loading,
        error: error,
      );

  bool get isLoggedIn => user != null && (token?.isNotEmpty ?? false);
}

final storageProvider = Provider<AppSecureStorage>((ref) => AppSecureStorage());

// Change baseUrl to your API root, e.g., https://example.com/api/
final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
      baseUrl: 'http://192.168.217.130:8080/', storage: ref.read(storageProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(apiClientProvider)),
);

class AuthController extends StateNotifier<AuthState> {
  final Ref ref;
  AuthController(this.ref) : super(const AuthState());

  Future<void> loadSession() async {
    final storage = ref.read(storageProvider);
    final token = await storage.readToken();
    final user = await storage.readUser();
    if (token != null && user != null) {
      state = AuthState(user: user, token: token, loading: false);
    }
  }

  Future<void> signUp(UserModel newUser) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final (user, token) =
          await ref.read(authRepositoryProvider).signUp(newUser);
      final storage = ref.read(storageProvider);
      await storage.saveToken(token);
      await storage.saveUser(user);
      state = AuthState(user: user, token: token, loading: false);
    } catch (e) {
      print("======================");
      print(e.toString());
      print("======================");
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> login({required String psid, required String password}) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final (user, token) = await ref
          .read(authRepositoryProvider)
          .login(psid: psid, password: password);
      final storage = ref.read(storageProvider);
      await storage.saveToken(token);
      await storage.saveUser(user);
      state = AuthState(user: user, token: token, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(loading: true);
    await ref.read(storageProvider).clear();
    state = const AuthState(loading: false);
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
    (ref) => AuthController(ref));
