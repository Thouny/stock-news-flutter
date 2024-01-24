import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/theme/border_radius.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';
import 'package:stock_news_flutter/core/theme/theme.dart';

class SNErrorCardStyle {
  SNErrorCardStyle._();

  static final roundErrorCard = SNTheme.appTheme.copyWith(
    cardTheme: const CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusValues.medium),
        ),
        side: BorderSide(color: Color(0xFFE0E0E0)),
      ),
    ),
    iconTheme: const IconThemeData(color: SNColors.red, size: 40),
  );
}
