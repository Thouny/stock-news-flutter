import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';

class SNTheme {
  SNTheme._();

  static ThemeData get appTheme {
    return ThemeData(
      cardColor: Colors.white,
      scaffoldBackgroundColor: SNColors.coolGrey.shade200,
      primaryColor: SNColors.blue,
      primaryColorLight: SNColors.lightBlue,
      primaryColorDark: SNColors.darkBlue,
      dividerColor: SNColors.grey.shade300,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: SNColors.blue,
        selectedIconTheme: const IconThemeData(color: SNColors.blue),
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        unselectedIconTheme: IconThemeData(color: SNColors.coolGrey.shade600),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        unselectedItemColor: SNColors.coolGrey.shade600,
      ),
    );
  }
}
