import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/features/stock/data/datasources/stock_remote_datasource.dart';
import 'package:stock_news_flutter/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_historical_stock.dart';

void init(GetIt serviceLocator) {
  // data sources
  serviceLocator.registerLazySingleton<StockRemoteDataSource>(() {
    return StockRemoteDataSourceImpl(
      client: serviceLocator(),
      storage: serviceLocator(),
    );
  });
  // repositories
  serviceLocator.registerLazySingleton<StockRepository>(() {
    return StockRepositoryImpl(
      connectionService: serviceLocator(),
      remoteDataSource: serviceLocator(),
    );
  });
  // usecases
  serviceLocator.registerLazySingleton<GetHistoricalStockUsecase>(() {
    return GetHistoricalStockUsecase(repository: serviceLocator());
  });
}
