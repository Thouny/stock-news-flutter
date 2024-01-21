import 'package:routemaster/routemaster.dart';
import 'package:stock_news_flutter/core/widgets/root_page_tab_scaffold.dart';
import 'package:stock_news_flutter/pages/home/home_page.dart';
import 'package:stock_news_flutter/pages/root/empty_page.dart';
import 'package:stock_news_flutter/pages/setttings/settings_page.dart';
import 'package:stock_news_flutter/pages/stocks/stocks_page.dart';
import 'package:stock_news_flutter/routing/initial_page_routes.dart';
import 'package:stock_news_flutter/routing/routes.dart';

class PageRoutes {
  static final empty = RouteMap(
    routes: {
      Routes.empty: (_) => EmptyPage(),
    },
    onUnknownRoute: (_) => const Redirect(Routes.empty),
  );

  static final home = RouteMap(
    routes: {
      // `/`
      // Be mindful of ordering, must match expected bottom nav order
      Routes.root: (route) => const TabPage(
            child: RootPageTabScaffold(),
            paths: [
              Routes.home,
              Routes.tracker,
              Routes.settings,
            ],
          ),

      /// **********************************************************************
      /// home
      /// **********************************************************************
      // `/home`
      Routes.home: (_) => HomePage(),

      /// **********************************************************************
      /// stocks
      /// **********************************************************************
      // `/stocks`
      Routes.tracker: (_) => StocksPage(),

      /// **********************************************************************
      /// settings
      /// **********************************************************************
      // `/settings`
      Routes.settings: (_) => SettingsPage(),
    },
    onUnknownRoute: (path) => const Redirect(InitialPageRoutes.empty),
  );
}
