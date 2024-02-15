import 'package:accountant_app/constants/app_constants/routes_constants.dart';
import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/providers/signIn_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  final String loginPageRoute = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, right: 16.0, left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoHandler(
                margin: EdgeInsets.only(bottom: 40.0),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: signInProvider.emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: AppLocalizations.of(context)!.email,
                ),
              ),
              TextFormField(
                controller: signInProvider.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  labelText: AppLocalizations.of(context)!.password,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await signInProvider.signIn(context: context);
                },
                child: Text(AppLocalizations.of(context)!.login),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, PageRoutes().registerPageRoute);
                  },
                  child: Text(AppLocalizations.of(context)!
                      .clickHereIfYouDoNotHaveAnAccount))
            ],
          ),
        ),
      ),
    );
  }
}
