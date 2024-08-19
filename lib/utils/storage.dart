import 'package:shared_preferences/shared_preferences.dart';

class Default {
  final String key;

  Default(this.key);

  Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> set(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

// Tạo các biến tương tự như trong mã gốc
final accessToken = Default('accessToken');
final refreshTokenStorage = Default('refreshToken');
final clientId = Default('x-client-id');
