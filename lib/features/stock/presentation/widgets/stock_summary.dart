import 'package:flutter/material.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';

class StockSummary extends StatelessWidget {
  final CompanyEntity company;
  final StockEntity stock;

  const StockSummary({super.key, required this.company, required this.stock});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
