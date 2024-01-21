import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';

class StockConsts {
  StockConsts._();

  static const List<CompanyEntity> companyWatchlist = [
    CompanyEntity(name: 'Apple Inc.', symbol: 'AAPL'),
    CompanyEntity(name: 'Netflix Inc.', symbol: 'NFLX'),
    CompanyEntity(name: 'Microsoft Corporation', symbol: 'MSFT'),
    CompanyEntity(name: 'Amazon.com Inc.', symbol: 'AMZN'),
    CompanyEntity(name: 'Alphabet Inc.', symbol: 'GOOG'),
    CompanyEntity(name: 'Meta Platforms Inc.', symbol: 'META'),
    CompanyEntity(name: 'Tesla Inc.', symbol: 'TSLA'),
    CompanyEntity(name: 'NVIDIA Corporation', symbol: 'NVDA'),
  ];
}
