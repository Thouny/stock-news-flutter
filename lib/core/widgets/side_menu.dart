import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stock_news_flutter/core/consts/app_consts.dart';
import 'package:stock_news_flutter/core/theme/app_colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final tabState = TabPage.of(context);
    return Drawer(
      backgroundColor: AppColors.secondaryColor,
      child: Column(
        children: [
          DrawerHeader(
            child: Text(AppConsts.appName,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white)),
          ),
          _DrawerListTile(
            title: AppConsts.home,
            press: () {
              tabState.controller.animateTo(0);
            },
            icon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.home, color: Colors.white),
            ),
          ),
          _DrawerListTile(
            title: AppConsts.tracker,
            press: () {
              tabState.controller.animateTo(1);
            },
            icon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.ssid_chart_rounded, color: Colors.white),
            ),
          ),
          _DrawerListTile(
            title: AppConsts.settings,
            press: () {
              tabState.controller.animateTo(2);
            },
            icon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.settings, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  const _DrawerListTile({
    Key? key,
    required this.title,
    required this.press,
    this.icon,
  }) : super(key: key);

  final String title;
  final IconButton? icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
