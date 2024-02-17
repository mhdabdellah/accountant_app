import 'package:accountant_app/constants/app_constants/app.dart';
import 'package:accountant_app/constants/app_constants/theme_constant.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:accountant_app/providers/signIn_provider.dart';
import 'package:accountant_app/providers/signup_provider.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/screens/register_screen.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/splash_screen.dart';

void main() async {
  await supabase.Supabase.initialize(
      url: supabaseProjectURL, anonKey: supabaseApiKey);

  runApp(ChangeNotifierProvider(
      create: (_) => CurrentUserProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      locale: Locale(getDeviceLanguage(context)),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],
      theme: principalTheme,
      initialRoute: const SplashScreen().splashScreenPageRoute,
      routes: {
        const SplashScreen().splashScreenPageRoute: (context) =>
            const SplashScreen(),
        const LoginPage().loginPageRoute: (context) => ChangeNotifierProvider(
            create: (_) => SignInProvider(), child: const LoginPage()),
        const RegisterPage().registerPageRoute: (context) =>
            ChangeNotifierProvider(
                create: (_) => SignUpProvider(), child: const RegisterPage()),
        const TransactionPage().transactionsPageRoute: (context) =>
            ChangeNotifierProvider(
                create: (_) => TransactionProvider(
                    userId: currentUserProvider.currentUserId,
                    context: context),
                child: const TransactionPage())
      },
    );
  }
}
