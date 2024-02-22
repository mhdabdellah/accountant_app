import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/screens/register_screen.dart';
import 'package:accountant_app/screens/splash_screen.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:flutter/cupertino.dart';

class AppNavigator {
  static final key = GlobalKey<NavigatorState>();
  static NavigatorState get state => key.currentState!;

  static BuildContext get context => key.currentContext!;

  static Future<T?> pushReplacement<T>(String route) =>
      state.pushReplacementNamed(
        route,
      );

  static Route<dynamic>? onGeneratedRoute(RouteSettings routeSettings) {
    return CupertinoPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        final route = Uri.parse(routeSettings.name!);

        switch (route.path) {
          case LoginPage.loginPageRoute:
            return const LoginPage();

          case RegisterPage.registerPageRoute:
            return const RegisterPage();

          case TransactionPage.transactionsPageRoute:
            return const TransactionPage();

          default:
            return const SplashScreen();
        }
      },
    );
  }
}
