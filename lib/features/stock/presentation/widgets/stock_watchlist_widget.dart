import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/core/theme/border_radius.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/stock_detail_bottom_sheet.dart';
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

  void showModal(BuildContext context, CompanyEntity company) {
    const radius = Radius.circular(BorderRadiusValues.xLarge);
    const borderRadius = BorderRadius.only(topLeft: radius, topRight: radius);
    const shape = RoundedRectangleBorder(borderRadius: borderRadius);

    showModalBottomSheet<void>(
      shape: shape,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: FractionallySizedBox(
            heightFactor: 0.90,
            child: StockDetailBottomSheetWrapper(company: company),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key('${StockWatchListWidget.keyPrefix}-ListView'),
      itemCount: StockConsts.companyWatchlist.length,
      itemBuilder: (context, index) {
        final company = StockConsts.companyWatchlist[index];
        return StockOverviewCardWrapper(
          company: company,
          onTap: () => showModal(context, company),
        );
      },
    );
  }
}
