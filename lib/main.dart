import 'package:accountant_app/constants/app_constants/app.dart';
import 'package:accountant_app/constants/app_constants/theme_constant.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig().initSupabaseDataConfig();
  await supabase.Supabase.initialize(
      url: SupabaseConfig().supabaseDataConfig['supabaseProjectURL'],
      anonKey: SupabaseConfig().supabaseDataConfig['supabaseApiKey']);

  runApp(ChangeNotifierProvider(
      create: (_) => CurrentUserProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      navigatorKey: AppNavigator.key,
      initialRoute: SplashScreen.splashScreenPageRoute,
      onGenerateRoute: AppNavigator.onGeneratedRoute,
    );
  }
}
