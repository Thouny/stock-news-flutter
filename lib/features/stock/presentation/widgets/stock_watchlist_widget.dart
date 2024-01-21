import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/stock_overview_card.dart';

class StockWatchListWidget extends StatelessWidget {
  static const keyPrefix = 'StockWatchListWidgetWrapper';

  const StockWatchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Stocks Watchlist",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: PaddingValues.small),
        const Expanded(child: _StockListView()),
      ],
    );
  }
}

class _StockListView extends StatelessWidget {
  const _StockListView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key('${StockWatchListWidget.keyPrefix}-ListView'),
      itemCount: StockConsts.companyWatchlist.length,
      itemBuilder: (context, index) {
        final symbol = StockConsts.companyWatchlist[index];
        return StockOverviewCardWrapper(company: symbol);
      },
    );
  }
}
