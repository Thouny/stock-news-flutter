import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/widgets/app_page.dart';
import 'package:stock_news_flutter/core/widgets/layout_delegate.dart';

class SettingsPage extends AppPage<void> {
  SettingsPage({
    String keyValue = 'settings',
    String routeName = 'settings',
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) : super(
          keyValue: keyValue,
          routeName: routeName,
          arguments: arguments,
        );

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) {
        return const SettingsView();
      },
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutDelegate(
      child: Center(
        child: Text('Settings'),
      ),
    );
  }
}
