import 'dart:io';

import 'package:accountant_app/helpers/navigation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplicationLocalization {
  static final translator = AppLocalizations.of(AppNavigator.context);

  static String getDeviceLanguage() {
    return Platform.localeName.split('_')[0];
  }
}
