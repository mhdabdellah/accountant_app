import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils.dart';
import 'package:accountant_app/providers/signup_provider.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatelessWidget {
  static const String registerPageRoute = '/register';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SignUpProvider(), child: const _RegisterPage());
  }
}

class _RegisterPage extends StatelessWidget {
  const _RegisterPage();

  @override
  Widget build(BuildContext context) {
    final signUpProvider = context.watch<SignUpProvider>();
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
                  controller: signUpProvider.firstnameController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: Utils.translator!.firstName,
                  ),
                  validator: (value) => Utils.isEmpty(value!)),
              TextFormField(
                  controller: signUpProvider.lastnameController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: Utils.translator!.lastName,
                  ),
                  validator: (value) => Utils.isEmpty(value!)),
              TextFormField(
                  controller: signUpProvider.emailController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email),
                    labelText: Utils.translator!.email,
                  ),
                  validator: (value) => Utils.isEmailValid(value)),
              TextFormField(
                  controller: signUpProvider.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    labelText: Utils.translator!.password,
                  ),
                  validator: (value) => Utils.isPasswordValid(value)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await context.read<SignUpProvider>().signUp();
                },
                child: Text(Utils.translator!.register),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    AppNavigator.pushReplacement(LoginPage.loginPageRoute);
                  },
                  child: Text(Utils.translator!.clickHereIfYouHaveAnAccount))
            ],
          ),
        ),
      ),
    );
  }
}
