import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/widgets/app_page.dart';
import 'package:stock_news_flutter/core/widgets/layout_delegate.dart';
import 'package:stock_news_flutter/routing/initial_page_routes.dart';

class HomePage extends AppPage<void> {
  HomePage({
    String keyValue = InitialPageRoutes.home,
    String routeName = InitialPageRoutes.home,
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
        return const HomeView();
      },
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LayoutDelegate(
      child: Center(
        child: Text('Home'),
      ),
    );
  }
}
