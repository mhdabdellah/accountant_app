import 'package:accountant_app/helpers/exceptions/exception_handler_response.dart';
import 'package:accountant_app/helpers/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomExceptionHandler {
  CustomExceptionHandler._internal();
  static final CustomExceptionHandler _instance =
      CustomExceptionHandler._internal();
  factory CustomExceptionHandler() => _instance;
  String exceptionHandler(dynamic error) {
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

  Future<ExceptionHandlerResponse<T>> exceptionCatcher<T>(
      {required Future<T> Function() function}) async {
    try {
      return ExceptionHandlerResponse(result: await function.call());
    } catch (error) {
      return ExceptionHandlerResponse<T>(error: exceptionHandler(error));
    }
  }
}
