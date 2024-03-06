import 'package:accountant_app/custom_widgets/button.dart';
import 'package:accountant_app/custom_widgets/input.dart';
import 'package:accountant_app/custom_widgets/logo.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils/validators.dart';
import 'package:accountant_app/providers/signup_provider.dart';
import 'package:accountant_app/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatelessWidget {
  static const String pageRoute = '/register';
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SignUpProvider(), child: const _SignUpPage());
  }
}

class _SignUpPage extends StatelessWidget {
  const _SignUpPage();

  @override
  Widget build(BuildContext context) {
    final signUpProvider = context.watch<SignUpProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40.0, right: 16.0, left: 16.0),
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
              controller: signUpProvider.firstnameController,
              keyboardType: TextInputType.text,
              label: ApplicationLocalization.translator.firstName,
              iconData: Icons.person,
              validator: (value) => Validator.isEmpty(value),
            ),
            Input(
              controller: signUpProvider.lastnameController,
              keyboardType: TextInputType.text,
              label: ApplicationLocalization.translator.lastName,
              iconData: Icons.person,
              validator: (value) => Validator.isEmpty(value),
            ),
            Input(
              controller: signUpProvider.emailController,
              keyboardType: TextInputType.text,
              label: ApplicationLocalization.translator.email,
              iconData: Icons.email,
              validator: (value) => Validator.isEmailValid(value),
            ),
            Input(
              controller: signUpProvider.passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              label: ApplicationLocalization.translator.password,
              iconData: Icons.lock,
              validator: (value) => Validator.isPasswordValid(value),
            ),
            const SizedBox(height: 20),
            Button(
              text: ApplicationLocalization.translator.register,
              onPressed: () async {
                await signUpProvider.signUp();
              },
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  AppNavigator.pushReplacement(SignInPage.pageRoute);
                },
                child: Text(ApplicationLocalization
                    .translator.clickHereIfYouHaveAnAccount))
          ],
        ),
      ),
    );
  }
}
