import 'package:accountant_app/custom_widgets/logo.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String pageRoute = '/';

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => CurrentUserProvider().userVerification(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const size = 370.0;

    return const Scaffold(
      body: Logo(
        margin: EdgeInsets.only(top: 200.0),
        height: size,
        width: size,
      ),
    );
  }
}
