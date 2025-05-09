import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';

class BottomNavigationTabBarTheme {
  static const Color tabIconSelectedColor = Colors.white;
  static const Color tabIconColor = Colors.blue;
  static const Color tabSelectedColor = Colors.blue;
  static const double tabIconSize = 28.0;
  static const double tabIconSelectedSize = 26.0;
  static const double tabSize = 50;
  static const double tabBarHeight = 55;
  static const Color tabBarColor = Color(0xFFAFAFAF);

  static const String initialSelectedTab = "Add";

  static const TextStyle textStyle = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  static const labels = ["Add", "Transactions", "Expenses", "Incomes", "About"];

  static const icons = [
    Icons.add,
    Icons.list,
    Icons.money_off,
    Icons.attach_money,
    Icons.open_in_new
  ];

  static const primaryBadges = [null, null, null, null, null];

  static const seconderyBadges = [
    MotionBadgeWidget(
      text: '990',
      textColor: Colors.white, // optional, default to Colors.white
      color: Colors.black, // optional, default to Colors.red
      size: 18, // optional, default to 18
    ),

    MotionBadgeWidget(
      text: '990',
      textColor: Colors.white, // optional, default to Colors.white
      color: Colors.black, // optional, default to Colors.red
      size: 18, // optional, default to 18
    ),
    MotionBadgeWidget(
      text: '99+',
      textColor: Colors.white, // optional, default to Colors.white
      color: Colors.red, // optional, default to Colors.red
      size: 18, // optional, default to 18
    ),
    MotionBadgeWidget(
      text: '99+',
      textColor: Colors.white, // optional, default to Colors.white
      color: Colors.green, // optional, default to Colors.red
      size: 18, // optional, default to 18
    ),
    // Default Motion Badge Widget with indicator only
    MotionBadgeWidget(
      isIndicator: true,
      color: Colors.red, // optional, default to Colors.red
      size: 5, // optional, default to 5,
      show: true, // true / false
    ),
  ];
}
