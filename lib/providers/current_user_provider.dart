import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:accountant_app/models/user_model.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final customExceptionHandler = CustomExceptionHandler();

  UserModel? currentUser;

  String get currentUserId {
    String userId = client.auth.currentSession?.user.id ?? "";
    return userId;
  }

  Future<UserModel?> getCurrentUser(BuildContext context) async {
    try {
      currentUser = await _authService.getCurrentUser(currentUserId);
      notifyListeners();
      return currentUser;
    } catch (error) {
      SnackBarHelper.showErrorSnackBar(
          context, customExceptionHandler.handleException(context, error));
      return null;
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await _authService.signOut();
    } catch (error) {
      SnackBarHelper.showErrorSnackBar(
          context, customExceptionHandler.handleException(context, error));
    }
  }

  @override
  void dispose() {
    currentUser = UserModel();
    super.dispose();
  }
}
