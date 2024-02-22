import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:accountant_app/models/exception_handler_response_model.dart';

class CustomExceptionHandler {
  CustomExceptionHandler._internal();
  static final CustomExceptionHandler _instance =
      CustomExceptionHandler._internal();
  factory CustomExceptionHandler() => _instance;
  String exceptionHandler(dynamic error) {
    String errorMessage;
    if (error is FormatException) {
      errorMessage =
          '${ApplicationLocalization.translator!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is PostgrestException) {
      errorMessage =
          '${ApplicationLocalization.translator!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is AuthException) {
      errorMessage =
          '${ApplicationLocalization.translator!.unexpectedErrorOccurred} ${error.message}';
    } else {
      errorMessage =
          '${ApplicationLocalization.translator!.unexpectedErrorOccurred} $error';
    }

    return errorMessage;
  }

  Future<ExceptionHandlerResponseModel<T>> exceptionCatcher<T>(
      {required Future<T> Function() function,
      bool showSnackbar = true}) async {
    try {
      return ExceptionHandlerResponseModel(result: await function.call());
    } catch (error) {
      String errorMesssage = exceptionHandler(error);
      if (showSnackbar) {
        SnackBarHelper.showErrorSnackBar(errorMesssage);
      }
      return ExceptionHandlerResponseModel<T>(error: exceptionHandler(error));
    }
  }
}
