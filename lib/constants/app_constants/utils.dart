import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late GlobalKey<NavigatorState> navigatorKey;

class CustomExceptionHandler {
  String handleException(BuildContext context, dynamic error) {
    String errorMessage;
    if (error is FormatException) {
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is PostgrestException) {
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}';
    } else if (error is AuthException) {
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}';
    } else {
      errorMessage =
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} $error';
    }

    return errorMessage;
  }
}
