import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/period_button.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/stock_chart.dart';

class StockDetailWidget extends StatefulWidget {
  const StockDetailWidget({
    super.key,
    required this.company,
    required this.stocks,
  });

  final CompanyEntity company;
  final List<StockEntity> stocks;

  @override
  State<StockDetailWidget> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetailWidget> {
  int _selectedPeriodIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CompanyInfo(
          company: widget.company,
          stocks: widget.stocks,
          selectedPeriodIndex: _selectedPeriodIndex,
        ),
        _PeriodSelector(
          selectedPeriodIndex: _selectedPeriodIndex,
          onPeriodSelected: (index) {
            setState(() {
              _selectedPeriodIndex = index;
            });
          },
        ),
        StockChart(
          selectedPeriodIndex: _selectedPeriodIndex,
          stocks: widget.stocks,
        ),
      ],
    );
  }
}

class _CompanyInfo extends StatelessWidget {
  final CompanyEntity company;
  final List<StockEntity> stocks;
  final int selectedPeriodIndex;

  const _CompanyInfo({
    required this.company,
    required this.stocks,
    required this.selectedPeriodIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              company.symbol,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: PaddingValues.xSmall),
            Text(
              company.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Divider(),
        Text(
          stocks.first.close.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(StockConsts.periodOptions[selectedPeriodIndex].description),
        const SizedBox(height: PaddingValues.xxSmall),
        Text(
          company.exchange,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Divider(),
        const SizedBox(height: PaddingValues.xSmall),
      ],
    );
  }
}

class _PeriodSelector extends StatelessWidget {
  final int selectedPeriodIndex;
  final Function(int) onPeriodSelected;

  const _PeriodSelector({
    Key? key,
    required this.selectedPeriodIndex,
    required this.onPeriodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: StockConsts.periodOptions.map((period) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingValues.xSmall,
            ),
            child: PeriodButton(
              isSelected: StockConsts.periodOptions.indexOf(period) ==
                  selectedPeriodIndex,
              label: period.label,
              onPressed: () {
                onPeriodSelected(StockConsts.periodOptions.indexOf(period));
              },
            ),
          );
        }).toList(growable: false),
      ),
    );
  }
}
