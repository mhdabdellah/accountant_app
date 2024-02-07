import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthTransactionProvider>(context);

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
                  await authViewModel.signIn(
                      emailController.text, passwordController.text);

                  Navigator.pushReplacementNamed(
                    context,
                    "/transactions",
                  );
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
