import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final void Function(dynamic)? onChanged;
  // final VoidCallback onChanged;
  final String title;
  final dynamic value;
  final dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        title: Text(title),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged);
  }
}

// import 'package:flutter/material.dart';

// class RadioButton extends StatelessWidget {
//   const RadioButton({
//     Key? key,
//     required this.title,
//     required this.value,
//     required this.groupValue,
//     required this.onChanged,
//     this.activeColor = Colors.blue,
//     this.inactiveColor = Colors.grey,
//   }) : super(key: key);

//   final String title;
//   final dynamic value;
//   final dynamic groupValue;
//   final void Function(dynamic) onChanged;
//   final Color activeColor;
//   final Color inactiveColor;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title),
//       leading: Radio<dynamic>(
//         value: value,
//         groupValue: groupValue,
//         onChanged: onChanged,
//         activeColor: activeColor,
//         inactiveColor: inactiveColor,
//       ),
//     );
//   }
// }

