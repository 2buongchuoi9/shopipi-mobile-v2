// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:shopipi_mobile_v2/https/authApi.dart';
import 'package:shopipi_mobile_v2/models/user.dart';
import 'package:shopipi_mobile_v2/utils/storage.dart';

class AuthProvider extends ChangeNotifier {
  User _user = User.initialUser();
  bool _isAuthenticated = false;

  User get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> fetchUser() async {
    try {
      final user = await authApi.getProfile();
      _user = user;
      _isAuthenticated = true;
    } catch (e) {
      _user = User.initialUser();
      _isAuthenticated = false;
      print('Failed to fetch user: $e');
    }
    notifyListeners();
  }

  void logout() {
    _user = User.initialUser();
    _isAuthenticated = false;
    accessToken.remove();
    clientId.remove();
    notifyListeners();
  }
}
