import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';

abstract class StockRepository {
  Future<Either<Failure, List<StockEntity>>> getHistoricalStock();
}
