import 'package:flutter/material.dart';

class BottomNavbarStyle {
  const BottomNavbarStyle._();

  static const animationDuration = 200;
  static const indicatorHeight = 2.0;
  static Color get selectedIndicatorColor {
    return Colors.blue.shade400;
  }

  static Color get unselectedIndicatorColor {
    return Colors.grey.shade300;
  }

  static Color get iconSelectedIndicatorColor {
    return Colors.blue.shade50;
  }

  static const iconSize = 28.0;
  static const boxShadow = [
    BoxShadow(
      blurRadius: 6,
      offset: Offset(0, -4),
      color: Color(0x19000000),
    ),
  ];
}
