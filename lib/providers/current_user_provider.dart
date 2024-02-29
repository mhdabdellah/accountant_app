import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/models/user_model.dart';
import 'package:accountant_app/screens/signin_page.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  CurrentUserProvider._internal();

  static final CurrentUserProvider _currentUserProviderInstance =
      CurrentUserProvider._internal();

  final customExceptionHandler = ExceptionHandler();

  UserModel? currentUser;

  String get currentUserId {
    String userId = SupabaseConfig().currentUserId;
    return userId;
  }

  factory CurrentUserProvider() {
    return _currentUserProviderInstance;
  }

  Future<void> getCurrentUser() async {
    final response = await customExceptionHandler.exceptionCatcher<UserModel?>(
        function: () => _authService.getCurrentUser(currentUserId));

    if (!response.isError) {
      currentUser = response.result;
      notifyListeners();
    }
  }

  void userVerification() {
    AppNavigator.pushReplacement(SupabaseConfig().currentSession != null
        ? TransactionPage.pageRoute
        : SignInPage.pageRoute);
  }

  Future<void> logOut() async {
    final response = await customExceptionHandler.exceptionCatcher<void>(
        function: () => _authService.signOut());

    if (!response.isError) {
      AppNavigator.pushReplacement(SignInPage.pageRoute);
    }
  }
}
