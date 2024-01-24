import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';

abstract class StockRepository {
  Future<Either<Failure, List<StockEntity>>> getHistoricalStock(
    String symbol,
    DateTime from,
    DateTime to,
  );

  Future<Either<Failure, List<CompanyEntity>>> getCompaniesProfile(
    List<String> symbols,
  );
}
