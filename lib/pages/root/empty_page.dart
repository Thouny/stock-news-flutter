import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/widgets/app_page.dart';
import 'package:stock_news_flutter/routing/initial_page_routes.dart';

class EmptyPage extends AppPage<void> {
  EmptyPage({
    super.keyValue = InitialPageRoutes.empty,
    super.routeName = InitialPageRoutes.empty,
    super.arguments = const <String, dynamic>{},
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => const Scaffold(body: SizedBox.shrink()),
    );
  }
}
