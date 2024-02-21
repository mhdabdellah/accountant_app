import 'package:accountant_app/helpers/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

class ExceptionCatch {
  static Future<ErrorHandlerResponse<T>> catchErrors<T>(
      Future<T> Function() function) async {
    try {
      final result = await function.call();
      return ErrorHandlerResponse(result: result);
    } catch (error) {
      final String errorMessage =
          CustomExceptionHandler().handleException(error);
      return ErrorHandlerResponse<T>(error: errorMessage);
    }
  }
}

class ErrorHandlerResponse<T> {
  final String? error;
  final T? result;

  ErrorHandlerResponse({this.error, this.result});

  bool get isError => error != null;
}
