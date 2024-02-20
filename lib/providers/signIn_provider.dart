import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/snack_bar_helper.dart';

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

      await _authService.signIn(email, password);

      if (navigatorKey.currentState!.context.mounted) {
        SnackBarHelper.showSuccessSnackBar(Utils.translator!.logedSuccessfully);

        AppNavigator.pushReplacement(TransactionPage.transactionsPageRoute);
      }
    } catch (error) {
      SnackBarHelper.showErrorSnackBar(
          customExceptionHandler.handleException(error));
    }
  }
}
