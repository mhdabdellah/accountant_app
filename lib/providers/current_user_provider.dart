import 'package:accountant_app/constants/app_constants/exceptions_handler.dart';
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

  String? get currentUserId {
    String? userId = SupabaseConfig().currentUserId;
    return userId;
  }

  factory CurrentUserProvider() {
    return _currentUserProviderInstance;
  }

  Future<UserModel?> getCurrentUser() async {
    final response = await ExceptionCatch.catchErrors<UserModel?>(
        () => _authService.getCurrentUser(currentUserId!));

    if (response.isError) {
      SnackBarHelper.showErrorSnackBar(response.error!);
      return null;
    } else {
      currentUser = response.result;
      notifyListeners();
      return currentUser;
    }
  }

  Future<void> logOut() async {
    final response =
        await ExceptionCatch.catchErrors<void>(() => _authService.signOut());

    if (response.isError) {
      SnackBarHelper.showErrorSnackBar(response.error!);
    } else {
      if (AppNavigator.context.mounted) {
        // SnackBarHelper.showSuccessSnackBar(Utils.translator!.logedSuccessfully);
        AppNavigator.pushReplacement(LoginPage.loginPageRoute);
      }
    }
  }

  @override
  void dispose() {
    currentUser = UserModel();
    super.dispose();
  }
}
