import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/helpers/snack_bar_helper.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final customExceptionHandler = ExceptionHandler();

  SignInProvider();

  Future<void> signIn() async {
    final response = await customExceptionHandler.exceptionCatcher<void>(
        function: () =>
            _authService.signIn(emailController.text, passwordController.text));
    if (!response.isError) {
      SnackBarHelper.showSuccessSnackBar(
          ApplicationLocalization.translator!.logedSuccessfully);

      AppNavigator.pushReplacement(TransactionPage.pageRoute);
    }
  }
}
