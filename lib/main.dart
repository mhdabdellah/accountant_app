import 'package:accountant_app/constants.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/screens/register_screen.dart';
import 'package:accountant_app/screens/transaction_page.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(url: supabaseProjectURL, anonKey: supabaseApiKey);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthTransactionProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AccountantApp",
      theme: ThemeData(primarySwatch: Colors.blue),
      // initialRoute:
      //     client.auth.currentSession != null ? '/transactions' : "/login",
      home: client.auth.currentSession != null
          ? const TransactionPage()
          : LoginPage(),
      routes: {
        // '/': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/transactions': (context) => const TransactionPage(),
      },
    );
  }
}
