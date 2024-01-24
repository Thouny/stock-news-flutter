import 'package:stock_news_flutter/features/stock/presentation/view_models/period_view_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockConsts {
  StockConsts._();

  static const List<String> companySymbols = [
    'AAPL',
    // 'AMZN',
    'MSFT',
    // 'PYPL',
    'NFLX',
  ];

  static const List<PeriodViewModel> periodOptions = [
    PeriodViewModel(
      description: 'Past week',
      label: '1w',
      duration: 7,
      intervalType: DateTimeIntervalType.days,
      interval: 1,
    ),
    PeriodViewModel(
      description: 'Past month',
      label: '1m',
      duration: 30,
      intervalType: DateTimeIntervalType.days,
      interval: 7,
    ),
    PeriodViewModel(
      description: 'Past 3 months',
      label: '3m',
      duration: 90,
      intervalType: DateTimeIntervalType.months,
      interval: 1,
    ),
    PeriodViewModel(
      description: 'Past 6 months',
      label: '6m',
      duration: 180,
      intervalType: DateTimeIntervalType.months,
      interval: 1,
    ),
    PeriodViewModel(
      description: 'Past year',
      label: '1y',
      duration: 365,
      intervalType: DateTimeIntervalType.months,
      interval: 6,
    ),
    PeriodViewModel(
      description: 'Past 2 years',
      label: '2y',
      duration: 730,
      intervalType: DateTimeIntervalType.months,
      interval: 4,
    ),
  ];
}
