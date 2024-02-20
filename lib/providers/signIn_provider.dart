import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/snack_bar_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final customExceptionHandler = CustomExceptionHandler();

  SignInProvider();

  Future<void> signIn() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      if (!isEmailValid(email)) {
        throw const FormatException('Invalid email format');
      }
      if (!isPasswordValid(password)) {
        throw const FormatException('Password must meet strength requirements');
      }

      await _authService.signIn(email, password);

      if (navigatorKey.currentState!.context.mounted) {
        SnackBarHelper.showSuccessSnackBar(
            AppLocalizations.of(navigatorKey.currentState!.context)!
                .logedSuccessfully);

        AppNavigator.pushReplacement(TransactionPage.transactionsPageRoute);
      }
    } catch (error) {
      SnackBarHelper.showErrorSnackBar(
          customExceptionHandler.handleException(error));
    }
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$");

    return emailRegex.hasMatch(email);
  }

  bool isPasswordValid(password) {
    return password.length >= 8;
  }
}
