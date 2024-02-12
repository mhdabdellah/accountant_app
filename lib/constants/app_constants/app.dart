import 'package:flutter/material.dart';

import 'dart:io';

String title = "AccountantApp";

getDefaultLanguage(BuildContext context) {
  return Platform.localeName.split('_')[0];
}
