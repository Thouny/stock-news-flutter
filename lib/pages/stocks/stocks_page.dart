import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/core/widgets/app_page.dart';
import 'package:stock_news_flutter/core/widgets/layout_delegate.dart';
import 'package:stock_news_flutter/di/container.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/companies_profile_bloc.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/company_watchlist_widget.dart';
import 'package:stock_news_flutter/routing/initial_page_routes.dart';

class StocksPage extends AppPage<void> {
  StocksPage({
    String keyValue = InitialPageRoutes.stocks,
    String routeName = InitialPageRoutes.stocks,
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
        return BlocProvider<CompaniesProfileBloc>(
          create: (context) {
            final bloc = serviceLocator<CompaniesProfileBloc>();
            bloc.add(const LoadCompaniesProfileEvent(
              symbols: StockConsts.companySymbols,
            ));
            return bloc;
          },
          child: const StocksView(),
        );
      },
    );
  }
}

class StocksView extends StatelessWidget {
  const StocksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutDelegate(
        child: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(PaddingValues.small),
        child: CompanyWatchListWidget(),
      ),
    ));
  }
}
