import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final customExceptionHandler = CustomExceptionHandler();

  SignInProvider();

  Future<void> signIn() async {
    final response = await customExceptionHandler.catchErrors<void>(() =>
        _authService.signIn(emailController.text, passwordController.text));

    if (response.error != null) {
      SnackBarHelper.showErrorSnackBar(response.error!);
    } else {
      if (AppNavigator.context.mounted) {
        SnackBarHelper.showSuccessSnackBar(Utils.translator!.logedSuccessfully);

        AppNavigator.pushReplacement(TransactionPage.transactionsPageRoute);
      }
    }
  }
}
