import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/snack_bar_helper.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthTransactionProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
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
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final bool response = await authViewModel.signIn(
                        emailController.text, passwordController.text);
                    if (response) {
                      SnackBarHelper.showSuccessSnackBar(
                          context, "Login Successfully !");

                      Navigator.pushReplacementNamed(
                        context,
                        "/transactions",
                      );
                    } else {
                      SnackBarHelper.showErrorSnackBar(
                          context, 'Unexpected error occurred');
                    }
                  } catch (error) {
                    SnackBarHelper.showErrorSnackBar(
                        context, 'Unexpected error occurred');
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/register");
                  },
                  child: const Text("Click here if you don't have an account"))
            ],
          ),
        ),
      ),
    );
  }
}
