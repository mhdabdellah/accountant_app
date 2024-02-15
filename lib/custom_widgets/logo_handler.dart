import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogoHandler extends StatelessWidget {
  const LogoHandler({super.key, required this.margin, this.height, this.width});

  final double? height;
  final double? width;

  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: Column(
          children: [
            SizedBox(
                height: height ?? 250,
                width: width ?? 250,
                child: Lottie.asset("assets/logo.json")),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.accountant,
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context)!.app,
                  style: const TextStyle(
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
