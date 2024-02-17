import 'dart:async';

import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String splashScreenPageRoute = '/';
  final GlobalKey<NavigatorState> navigatorKey_;

  const SplashScreen({
    Key? key,
    required this.navigatorKey_,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigatorKey = widget.navigatorKey_;
    Timer(const Duration(seconds: 2), () async {
      navigatorKey.currentState!.pushReplacementNamed(
          client.auth.currentSession != null
              ? const TransactionPage().transactionsPageRoute
              : const LoginPage().loginPageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LogoHandler(
        margin: EdgeInsets.only(top: 200.0),
        height: 370,
        width: 370,
      ),
    );
  }
}
