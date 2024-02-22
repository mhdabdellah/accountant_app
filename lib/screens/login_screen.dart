import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils.dart';
import 'package:accountant_app/providers/signIn_provider.dart';
import 'package:accountant_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String loginPageRoute = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInProvider(),
      child: const _LoginPageBody(),
    );
  }
}

class _LoginPageBody extends StatelessWidget {
  const _LoginPageBody();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignInProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0, right: 16.0, left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoHandler(
              margin: EdgeInsets.only(bottom: 40.0),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: ApplicationLocalization.translator!.email,
                ),
                validator: (value) => Utils.isEmailValid(value)),
            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              validator: (value) => Utils.isPasswordValid(value),
              decoration: InputDecoration(
                icon: const Icon(Icons.lock),
                labelText: ApplicationLocalization.translator!.password,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.signIn,
              child: Text(ApplicationLocalization.translator!.login),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  AppNavigator.pushReplacement(RegisterPage.registerPageRoute);
                },
                child: Text(ApplicationLocalization
                    .translator!.clickHereIfYouDoNotHaveAnAccount))
          ],
        ),
      ),
    );
  }
}
