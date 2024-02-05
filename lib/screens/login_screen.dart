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
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
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

                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, "/transactions");
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => RegisterPage(),
                  //   ),
                  // );
                  Navigator.pushReplacementNamed(context, "/register");
                },
                child: const Text("Click here if you don't have an account"))
          ],
        ),
      ),
    );
  }
}
