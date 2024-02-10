import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/user_model.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? currentUser;

  Future<bool> signIn(String email, String password) async {
    bool loginResult = await _authService.signIn(email, password);
    if (loginResult == true && client.auth.currentSession?.user != null) {
      currentUser = await _authService
          .getCurrentUser(client.auth.currentSession?.user.id ?? "");
    }
    notifyListeners();
    return loginResult;
  }

  Future<bool> signUp(String firstnameController, String lastnameController,
      String email, String password) async {
    bool registerResult = await _authService.signUp(
        firstnameController, lastnameController, email, password);
    notifyListeners();
    return registerResult;
  }

  Future<bool> logOut() async {
    bool result = await _authService.signOut();
    notifyListeners();
    return result;
  }
}
