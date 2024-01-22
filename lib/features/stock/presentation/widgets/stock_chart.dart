import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockChart extends StatelessWidget {
  final int selectedPeriodIndex;
  final List<StockEntity> stocks;

  const StockChart({
    Key? key,
    required this.selectedPeriodIndex,
    required this.stocks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.30,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          intervalType:
              StockConsts.periodOptions[selectedPeriodIndex].intervalType,
          interval: StockConsts.periodOptions[selectedPeriodIndex].interval,
        ),
        primaryYAxis: const NumericAxis(opposedPosition: true),
        series: <CartesianSeries>[
          AreaSeries<StockEntity, DateTime>(
            dataSource: _getFilteredStocks,
            xValueMapper: (stock, _) => stock.date,
            yValueMapper: (stock, _) => stock.close,
            borderColor: _getStockLineColor,
            color: _getStockAreaColor,
            animationDuration: 400,
          ),
        ],
      ),
    );
  }

  List<StockEntity> get _getFilteredStocks {
    final duration = StockConsts.periodOptions[selectedPeriodIndex].duration;
    if (duration >= stocks.length) {
      return stocks;
    }

    final filteredList = stocks.sublist(0, duration);
    return filteredList;
  }

  Color get _getStockLineColor {
    return stocks.first.close < stocks.last.close
        ? SNColors.red
        : SNColors.green;
  }

  Color get _getStockAreaColor => _getStockLineColor.withOpacity(0.2);
}
