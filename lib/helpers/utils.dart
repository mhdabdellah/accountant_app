import 'package:accountant_app/helpers/navigation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Utils {
  static final translator = AppLocalizations.of(AppNavigator.context);

  static String? isEmpty(String value) {
    if (value.isEmpty) {
      return "cannot be empty";
    }
    return null;
  }

  static String? isEmailValid(String? email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$");

    if (emailRegex.hasMatch(email!)) {
      return null;
    } else {
      return 'Invalid email format';
    }
  }

  static String? isPasswordValid(String? password) {
    if (password!.length >= 8) {
      return null;
    } else {
      return 'Password must meet strength requirements';
    }
  }
}
