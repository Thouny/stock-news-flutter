import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'package:stock_news_flutter/core/widgets/app_page.dart';
import 'package:stock_news_flutter/core/widgets/layout_delegate.dart';
import 'package:stock_news_flutter/di/container.dart';
import 'package:stock_news_flutter/features/news/presentation/bloc/news_bloc.dart';
import 'package:stock_news_flutter/features/news/presentation/widgets/top_headlines_news_widget.dart';
import 'package:stock_news_flutter/features/user/presentation/blocs/greeting_bloc.dart';
import 'package:stock_news_flutter/features/user/presentation/widgets/greeting_widget.dart';
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
        return MultiBlocProvider(
          providers: [
            BlocProvider<GreetingBloc>(
              create: (context) {
                final bloc = serviceLocator<GreetingBloc>();
                bloc.add(const LoadGreetingEvent());
                return bloc;
              },
            ),
            BlocProvider<NewsBloc>(
              lazy: false,
              create: (context) {
                final bloc = serviceLocator<NewsBloc>();
                bloc.add(const LoadTopHeadlinesNewsEvent());
                return bloc;
              },
            ),
          ],
          child: const HomeView(),
        );
      },
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutDelegate(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingWidget(),
              const SizedBox(height: 16),
              Expanded(
                child: TopHealinesNewsWidget(
                  linkHandler: serviceLocator<LinkHandler>(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
