import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/consts/app_consts.dart';

enum BottomNavbarItemType {
  home(0, AppConsts.home, Icons.dashboard_rounded),
  stocks(1, AppConsts.stocks, Icons.ssid_chart_rounded),
  settings(2, AppConsts.settings, Icons.settings);

  final int tabIndex;
  final String label;
  final IconData icon;
  const BottomNavbarItemType(this.tabIndex, this.label, this.icon);
}
