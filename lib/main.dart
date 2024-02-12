import 'package:accountant_app/constants/app_constants/app.dart';
import 'package:accountant_app/constants/app_constants/routes_constants.dart';
import 'package:accountant_app/constants/app_constants/theme_constant.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/screens/register_screen.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supDatabase;

import 'providers/auth_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await supDatabase.Supabase.initialize(
      url: supabaseProjectURL, anonKey: supabaseApiKey);

  runApp(ChangeNotifierProvider(
      create: (_) => AuthProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      locale: Locale(getDefaultLanguage(context)),
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
      initialRoute: client.auth.currentSession != null ? transactions : login,
      routes: {
        login: (context) => LoginPage(),
        register: (context) => RegisterPage(),
        transactions: (context) => ChangeNotifierProvider(
            create: (_) => TransactionProvider(),
            child: const TransactionPage())
      },
    );
  }
}
