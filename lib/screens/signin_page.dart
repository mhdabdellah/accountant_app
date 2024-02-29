import 'package:accountant_app/custom_widgets/button.dart';
import 'package:accountant_app/custom_widgets/input.dart';
import 'package:accountant_app/custom_widgets/logo.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils/validators.dart';
import 'package:accountant_app/providers/signIn_provider.dart';
import 'package:accountant_app/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  static const String pageRoute = '/login';
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInProvider(),
      child: const _SignInPageBody(),
    );
  }
}

class _SignInPageBody extends StatelessWidget {
  const _SignInPageBody();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SignInProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0, right: 16.0, left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Logo(
              margin: EdgeInsets.only(bottom: 40.0),
            ),
            const SizedBox(
              height: 8,
            ),
            Input(
              controller: controller.emailController,
              keyboardType: TextInputType.text,
              label: ApplicationLocalization.translator!.email,
              iconData: Icons.email,
              validator: (value) => Validator.isEmailValid(value),
            ),
            Input(
              controller: controller.passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              label: ApplicationLocalization.translator!.password,
              iconData: Icons.lock,
              validator: (value) => Validator.isPasswordValid(value),
            ),
            const SizedBox(height: 20),
            Button(
              text: ApplicationLocalization.translator!.login,
              onPressed: controller.signIn,
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  AppNavigator.pushReplacement(SignUpPage.pageRoute);
                },
                child: Text(ApplicationLocalization
                    .translator!.clickHereIfYouDoNotHaveAnAccount))
          ],
        ),
      ),
    );
  }
}
