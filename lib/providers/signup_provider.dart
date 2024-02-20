import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/snack_bar_helper.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final customExceptionHandler = CustomExceptionHandler();

  SignUpProvider();

  Future<void> signUp() async {
    try {
      String firstname = firstnameController.text;
      String lastname = lastnameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      await _authService.signUp(firstname, lastname, email, password);
      if (navigatorKey.currentState!.context.mounted) {
        SnackBarHelper.showSuccessSnackBar(
            Utils.translator!.registredSuccessfully);

        AppNavigator.pushReplacement(LoginPage.loginPageRoute);
      }
    } catch (error) {
      SnackBarHelper.showErrorSnackBar(
          customExceptionHandler.handleException(error));
    }
  }
}
