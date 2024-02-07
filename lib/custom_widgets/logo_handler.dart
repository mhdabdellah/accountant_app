import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogoHandler extends StatelessWidget {
  const LogoHandler({super.key, required this.margin});

  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: Column(
          children: [
            SizedBox(
                height: 250,
                width: 250,
                child: Lottie.asset("assets/logo.json")),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Accountant",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "App",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ));
  }
}
