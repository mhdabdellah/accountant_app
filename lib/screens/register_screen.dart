import 'package:accountant_app/custom_widgets/logo_handler.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthTransactionProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Register'),
      // ),
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
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'First Name',
                ),
              ),
              TextFormField(
                controller: lastnameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Last Name',
                ),
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
                  await authViewModel.signUp(
                      firstnameController.text,
                      lastnameController.text,
                      emailController.text,
                      passwordController.text);
                  firstnameController.text = "";
                  lastnameController.text = "";
                  emailController.text = "";
                  passwordController.text = "";
                  // Naviguez vers la page suivante ou effectuez une action après l'inscription
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => LoginPage(),
                    //   ),
                    // );
                    // Navigator.pushNamed(context, "/login");
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: const Text("Click here if you have an account"))
            ],
          ),
        ),
      ),
    );
  }
}
