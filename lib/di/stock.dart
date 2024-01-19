import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_historical_stock.dart';

void init(GetIt serviceLocator) {
  // usecases
  serviceLocator.registerLazySingleton<GetHistoricalStockUsecase>(() {
    return GetHistoricalStockUsecase(repository: serviceLocator());
  });
}
