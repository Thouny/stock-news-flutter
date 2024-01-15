import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/widgets/app_page.dart';
import 'package:stock_news_flutter/core/widgets/layout_delegate.dart';
import 'package:stock_news_flutter/routing/initial_page_routes.dart';

class TrackerPage extends AppPage<void> {
  TrackerPage({
    String keyValue = InitialPageRoutes.tracker,
    String routeName = InitialPageRoutes.tracker,
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
        return const TrackerView();
      },
    );
  }
}

class TrackerView extends StatelessWidget {
  const TrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutDelegate(
      child: Center(
        child: Text('Tracker'),
      ),
    );
  }
}
