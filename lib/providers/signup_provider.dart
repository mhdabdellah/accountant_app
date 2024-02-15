import 'package:accountant_app/constants/app_constants/routes_constants.dart';
import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../custom_widgets/snack_bar_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final customExceptionHandler = CustomExceptionHandler();

  Future<void> signUp({required BuildContext context}) async {
    try {
      String firstname = firstnameController.text;
      String lastname = lastnameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      if (firstname.isEmpty) {
        throw const FormatException('Firstname cannot be empty');
      }

      if (lastname.isEmpty) {
        throw const FormatException('Firstname cannot be empty');
      }
      if (!isEmailValid(email)) {
        throw const FormatException('Invalid email format');
      }
      if (!isPasswordValid(password)) {
        throw const FormatException('Password must meet strength requirements');
      }

      await _authService.signUp(firstname, lastname, email, password);
      if (context.mounted) {
        SnackBarHelper.showSuccessSnackBar(
            context, AppLocalizations.of(context)!.registredSuccessfully);

        Navigator.pushReplacementNamed(context, PageRoutes().loginPageRoute);
      }
    } on Exception catch (error) {
      customExceptionHandler.handleException(context, error);
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
