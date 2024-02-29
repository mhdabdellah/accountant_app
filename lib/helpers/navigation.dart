import 'package:accountant_app/screens/signin_page.dart';
import 'package:accountant_app/screens/signup_page.dart';
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
          case SignInPage.pageRoute:
            return const SignInPage();

          case SignUpPage.pageRoute:
            return const SignUpPage();

          case TransactionPage.pageRoute:
            return const TransactionPage();

          default:
            return const SplashScreen();
        }
      },
    );
  }
}
