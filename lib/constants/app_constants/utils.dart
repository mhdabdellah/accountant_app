import 'package:accountant_app/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late GlobalKey<NavigatorState> navigatorKey;

class CustomExceptionHandler {
  CustomExceptionHandler._internal();
  static final CustomExceptionHandler _instance =
      CustomExceptionHandler._internal();
  factory CustomExceptionHandler() => _instance;
  String handleException(dynamic error) {
    String errorMessage;
    if (error is FormatException) {
      errorMessage =
          '${Utils.translator!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is PostgrestException) {
      errorMessage =
          '${Utils.translator!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is AuthException) {
      errorMessage =
          '${Utils.translator!.unexpectedErrorOccurred} ${error.message}';
    } else {
      errorMessage = '${Utils.translator!.unexpectedErrorOccurred} $error';
    }

    return errorMessage;
  }
}
