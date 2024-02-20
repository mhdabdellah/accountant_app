import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/models/user_model.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  CurrentUserProvider._internal();

  static final CurrentUserProvider _currentUserProviderInstance =
      CurrentUserProvider._internal();

  final customExceptionHandler = CustomExceptionHandler();

  UserModel? currentUser;

  String get currentUserId {
    String userId = client.auth.currentSession?.user.id ?? "";
    return userId;
  }

  factory CurrentUserProvider() {
    return _currentUserProviderInstance;
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      currentUser = await _authService.getCurrentUser(currentUserId);
      notifyListeners();
      return currentUser;
    } catch (error) {
      SnackBarHelper.showErrorSnackBar(
          customExceptionHandler.handleException(error));
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      await _authService.signOut();
      AppNavigator.pushReplacement(LoginPage.loginPageRoute);
    } catch (error) {
      SnackBarHelper.showErrorSnackBar(
          customExceptionHandler.handleException(error));
    }
  }

  @override
  void dispose() {
    currentUser = UserModel();
    super.dispose();
  }
}
