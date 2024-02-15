import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomExceptionHandler {
  void handleException(BuildContext context, Exception error) {
    if (error is FormatException) {
      SnackBarHelper.showErrorSnackBar(context,
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}');
    } else if (error is PostgrestException) {
      SnackBarHelper.showErrorSnackBar(context,
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}');
    } else if (error is AuthException) {
      SnackBarHelper.showErrorSnackBar(context,
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} ${error.message}');
    } else {
      SnackBarHelper.showErrorSnackBar(context,
          '${AppLocalizations.of(context)!.unexpectedErrorOccurred} $error');
    }
  }

  // if (snapshot.ConnectionState != ConnectionState.done) {
  //     return const CircularProgressIndicator();
  //   } else if (!snapshot.hasError && snapshot.hasData) {
  //     return Text(snapshot.data!);
  //   } else {
  //     return Text('error');
  //   }
}
