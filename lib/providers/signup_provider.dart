import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/screens/signin_page.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../helpers/snack_bar_helper.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final customExceptionHandler = ExceptionHandler();

  SignUpProvider();

  Future<void> signUp() async {
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    final response = await customExceptionHandler.exceptionCatcher<void>(
        function: () =>
            _authService.signUp(firstname, lastname, email, password));

    if (response.isError) return;
    SnackBarHelper.showSuccessSnackBar(
        ApplicationLocalization.translator.registredSuccessfully);
    AppNavigator.pushReplacement(SignInPage.pageRoute);
  }
}
