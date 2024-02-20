import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/screens/register_screen.dart';
import 'package:accountant_app/screens/splash_screen.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppNavigator {
  static final key = GlobalKey<NavigatorState>();
  static NavigatorState get state => key.currentState!;
  static final currentUserProvider = context.watch<CurrentUserProvider>();

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
        Widget screen;

        switch (route.path) {
          case LoginPage.loginPageRoute:
            screen = const LoginPage();
            break;

          case RegisterPage.registerPageRoute:
            screen = const RegisterPage();
            break;

          case TransactionPage.transactionsPageRoute:
            screen = const TransactionPage();
            break;

          default:
            screen = SplashScreen(
              navigatorKey_: key,
            );
        }
        return screen;
      },
    );
  }
}
