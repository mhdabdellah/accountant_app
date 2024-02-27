import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {Key? key,
      required this.controller,
      this.obscureText,
      required this.keyboardType,
      required this.label,
      required this.iconData,
      this.iconColor,
      this.validator,
      this.maxLength})
      : super(key: key);

  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType keyboardType;
  final String label;
  final IconData iconData;
  final Color? iconColor;
  final String? Function(String?)? validator;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: maxLength,
        validator: validator,
        controller: controller,
        obscureText: obscureText == null ? false : obscureText!,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          icon: Icon(iconData),
          labelText: label,
        ));
  }
}
