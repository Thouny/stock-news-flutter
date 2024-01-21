import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';

class GetHistoricalStockUsecase
    implements Usecase<List<StockEntity>, GetHistoricalStockParams> {
  final StockRepository repository;

  GetHistoricalStockUsecase({required this.repository});

  @override
  Future<Either<Failure, List<StockEntity>>> call(
    GetHistoricalStockParams params,
  ) async {
    return repository.getHistoricalStock(params.symbol, params.from, params.to);
  }
}

class GetHistoricalStockParams extends Equatable {
  final String symbol;
  final DateTime from;
  final DateTime to;

  const GetHistoricalStockParams({
    required this.symbol,
    required this.from,
    required this.to,
  });

  @override
  List<Object?> get props => [symbol, from, to];
}
