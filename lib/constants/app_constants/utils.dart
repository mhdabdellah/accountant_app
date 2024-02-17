import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomExceptionHandler {
  String handleException(BuildContext context, dynamic error) {
    String errorMessage;
    if (error is FormatException) {
      // SnackBarHelper.showErrorSnackBar(context,
      //     '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}');
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is PostgrestException) {
      // SnackBarHelper.showErrorSnackBar(context,
      //     '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}');
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is AuthException) {
      // SnackBarHelper.showErrorSnackBar(context,
      //     '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}');
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}';
    } else {
      // SnackBarHelper.showErrorSnackBar(context,
      //     '${AppLocalizations.of(context)!.unexpectedErrorOccurred} $error');
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} $error';
    }

    return errorMessage;
  }
}
