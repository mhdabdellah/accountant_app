import 'package:accountant_app/constants/app_constants/routes_constants.dart';
import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatelessWidget {
  final String registerPageRoute = '/register';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 16.0, left: 16.0),
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
                controller: authProvider.firstnameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: AppLocalizations.of(context)!.firstName,
                ),
              ),
              TextFormField(
                controller: authProvider.lastnameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: AppLocalizations.of(context)!.lastName,
                ),
              ),
              TextFormField(
                controller: authProvider.emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: AppLocalizations.of(context)!.email,
                ),
              ),
              TextFormField(
                controller: authProvider.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  labelText: AppLocalizations.of(context)!.password,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await authProvider.signUp(context: context);
                },
                child: Text(AppLocalizations.of(context)!.register),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, PageRoutes().loginPageRoute);
                  },
                  child: Text(AppLocalizations.of(context)!
                      .clickHereIfYouHaveAnAccount))
            ],
          ),
        ),
      ),
    );
  }
}
