import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';

class GetHistoricalStockUsecase
    implements Usecase<List<StockEntity>, NoParams> {
  final StockRepository repository;

  GetHistoricalStockUsecase({required this.repository});

  @override
  Future<Either<Failure, List<StockEntity>>> call(NoParams params) async {
    return await repository.getHistoricalStock();
  }
}
