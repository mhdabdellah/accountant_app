import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';

class BottomNavigationTabBarTheme {
  Color tabIconSelectedColor = Colors.white;
  Color tabIconColor = Colors.blue;
  Color tabSelectedColor = Colors.blue;
  double? tabIconSize = 28.0;
  double? tabIconSelectedSize = 26.0;
  double tabSize = 50;
  double tabBarHeight = 55;
  Color tabBarColor = const Color(0xFFAFAFAF);

  String initialSelectedTab = "Add";

  TextStyle textStyle = const TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  var labels = const ["Add", "Transactions", "Expenses", "Incomes", "About"];

  var icons = const [
    Icons.add,
    Icons.list,
    Icons.money_off,
    Icons.attach_money,
    Icons.open_in_new
  ];

  var primaryBadges = [null, null, null, null, null];

  var seconderyBadges = [
    // custom badge Widget
    Container(
      color: Colors.black,
      padding: const EdgeInsets.all(2),
      child: const Text(
        '48',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
    const MotionBadgeWidget(
      text: '990',
      textColor: Colors.white, // optional, default to Colors.white
      color: Colors.black, // optional, default to Colors.red
      size: 18, // optional, default to 18
    ),
    const MotionBadgeWidget(
      text: '99+',
      textColor: Colors.white, // optional, default to Colors.white
      color: Colors.red, // optional, default to Colors.red
      size: 18, // optional, default to 18
    ),
    const MotionBadgeWidget(
      text: '99+',
      textColor: Colors.white, // optional, default to Colors.white
      color: Colors.green, // optional, default to Colors.red
      size: 18, // optional, default to 18
    ),
    // Default Motion Badge Widget with indicator only
    const MotionBadgeWidget(
      isIndicator: true,
      color: Colors.red, // optional, default to Colors.red
      size: 5, // optional, default to 5,
      show: true, // true / false
    ),
  ];
}
