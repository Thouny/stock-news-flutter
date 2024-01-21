import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stock_news_flutter/core/consts/app_consts.dart';
import 'package:stock_news_flutter/core/consts/env_consts.dart';
import 'package:stock_news_flutter/core/controller/menu_controller.dart'
    as controller;
import 'package:stock_news_flutter/core/enums/storage_keys.dart';
import 'package:stock_news_flutter/core/storage/secure_storage.dart';
import 'package:stock_news_flutter/core/theme/theme.dart';
import 'package:stock_news_flutter/di/container.dart';
import 'package:stock_news_flutter/routing/page_routes.dart';

import 'di/container.dart' as di;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  final storage = serviceLocator<SecureStorage>();
  const newsApiKey = String.fromEnvironment(EnvConsts.newsApiKey);
  const financialModelingPrepApiKey =
      String.fromEnvironment(EnvConsts.financialModelingPrepApiKey);
  await storage.write(StorageKeys.newsApiKey.name, newsApiKey);
  await storage.write(
    StorageKeys.financialModelingPrepApiKey.name,
    financialModelingPrepApiKey,
  );

  runApp(const AppWrapper());
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<controller.MenuController>(
            create: (context) => controller.MenuController())
      ],
      child: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final RoutemasterDelegate routemaster;

  @override
  void initState() {
    super.initState();
    routemaster = RoutemasterDelegate(
      routesBuilder: (context) => PageRoutes.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConsts.appName,
      theme: SNTheme.appTheme,
      routeInformationParser: const RoutemasterParser(),
      routerDelegate: routemaster,
      builder: (context, child) => MediaQuery(
        // override OS-level font scaling
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
