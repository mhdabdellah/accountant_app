import 'package:accountant_app/constants/app_constants/routes_constants.dart';
import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:accountant_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                controller: firstnameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: AppLocalizations.of(context)!.firstName,
                ),
              ),
              TextFormField(
                controller: lastnameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: AppLocalizations.of(context)!.lastName,
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: AppLocalizations.of(context)!.email,
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  labelText: AppLocalizations.of(context)!.password,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await authProvider.signUp(
                        firstnameController.text,
                        lastnameController.text,
                        emailController.text,
                        passwordController.text);
                    firstnameController.text = "";
                    lastnameController.text = "";
                    emailController.text = "";
                    passwordController.text = "";
                    SnackBarHelper.showSuccessSnackBar(context,
                        AppLocalizations.of(context)!.registredSuccessfully);

                    Navigator.pushReplacementNamed(context, login);
                  } catch (error) {
                    SnackBarHelper.showErrorSnackBar(context,
                        AppLocalizations.of(context)!.unexpectedErrorOccurred);
                  }
                },
                child: Text(AppLocalizations.of(context)!.register),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, login);
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
