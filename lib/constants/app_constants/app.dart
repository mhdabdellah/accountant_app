import 'package:flutter/material.dart';

import 'dart:io';

String title = "AccountantApp";

getDeviceLanguage(BuildContext context) {
  return Platform.localeName.split('_')[0];
}
