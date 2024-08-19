import 'package:shopipi_mobile_v2/https/http.dart';
import 'package:shopipi_mobile_v2/utils/storage.dart';

import '../models/user.dart';

class Token {
  final String accessToken;
  final String refreshToken;

  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}

class Auth {
  final User user;
  final Token token;

  Auth({
    required this.user,
    required this.token,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'token': token.toJson(),
      };
}

class AuthApi {
  final Http _http = Http();

  Future<Auth> login(Map<String, dynamic> body) async {
    try {
      final responseJson = await _http.post('/auth/login', body: body);
      print(responseJson.runtimeType);
      print(responseJson);
      final auth = Auth.fromJson(responseJson['data']);

      // Lưu token vào storage
      await accessToken.set(auth.token.accessToken);
      await clientId.set(auth.user.id);

      return auth;
    } catch (e) {
      print('Đăng nhập thất bại: $e');
      rethrow;
    }
  }

  Future<Auth> register(Map<String, dynamic> body) async {
    try {
      final responseJson = await _http.post('/auth/register', body: body);
      final response =
          Auth.fromJson(responseJson['data'] as Map<String, dynamic>);

      // Lưu token vào storage
      await accessToken.set(response.token.accessToken);
      await clientId.set(response.user.id);

      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Auth> registerShop(String id) async {
    try {
      final responseJson = await _http.post('/auth/register-shop/$id');
      final response =
          Auth.fromJson(responseJson['data'] as Map<String, dynamic>);

      // Lưu token vào storage
      await accessToken.set(response.token.accessToken);
      await clientId.set(response.user.id);

      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<User> getProfile() async {
    try {
      final responseJson = await _http.post('/user/profile');
      return User.fromJson(responseJson['data'] as Map<String, dynamic>);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<User> registerUserMod() async {
    try {
      final responseJson = await _http.get('/auth/create-user-mod');
      return User.fromJson(responseJson['data'] as Map<String, dynamic>);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<User> getShop(String shopId) async {
    try {
      final responseJson = await _http.get('/user/$shopId');
      return User.fromJson(responseJson['data'] as Map<String, dynamic>);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

final authApi = AuthApi();
