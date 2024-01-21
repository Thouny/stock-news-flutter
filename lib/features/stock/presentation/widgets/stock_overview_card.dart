import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/theme/border_radius.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/di/container.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/stock_bloc.dart';

class StockOverviewCardWrapper extends StatelessWidget {
  final CompanyEntity company;

  const StockOverviewCardWrapper({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return BlocProvider<StockBloc>(
      lazy: false,
      create: (context) {
        final bloc = serviceLocator<StockBloc>();
        bloc.add(LoadHistoricalStockEvent(
          symbol: company.symbol,
          from: today.subtract(const Duration(days: 3)),
          to: today,
        ));
        return bloc;
      },
      child: StockOverviewCardBuilder(company: company),
    );
  }
}

class StockOverviewCardBuilder extends StatelessWidget {
  static const keyPrefix = 'StockOverviewCard';

  final CompanyEntity company;

  const StockOverviewCardBuilder({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        if (state is LoadedStockState) {
          return _StockOverviewCard(
            key: const Key('$keyPrefix-Card'),
            company: company,
            stock: state.stocks.first,
          );
        } else if (state is ErrorStockState) {
          return Center(
            child: Text(
              state.message,
              key: const Key('$keyPrefix-ErrorText'),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              key: Key('$keyPrefix-LoadingIndicator'),
            ),
          );
        }
      },
    );
  }
}

class _StockOverviewCard extends StatelessWidget {
  final CompanyEntity company;
  final StockEntity stock;

  const _StockOverviewCard({
    super.key,
    required this.company,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        title: Text(company.symbol),
        subtitle: Text(company.name),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              stock.close.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            _ChangePercentWidget(changePercent: stock.changePercent),
          ],
        ),
      ),
    );
  }
}

class _ChangePercentWidget extends StatelessWidget {
  final double changePercent;

  const _ChangePercentWidget({required this.changePercent});

  String get _changePercentString {
    final changePercentString = changePercent.toStringAsFixed(2);
    if (!changePercent.isNegative) {
      return '+$changePercentString';
    } else {
      return changePercentString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PaddingValues.xxxSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          BorderRadiusValues.xSmallBorderRadius,
        ),
        color: changePercent.isNegative ? SNColors.red : SNColors.green,
      ),
      child: Text(
        _changePercentString,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
