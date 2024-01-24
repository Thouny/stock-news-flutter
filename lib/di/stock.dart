import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/features/stock/data/datasources/stock_remote_datasource.dart';
import 'package:stock_news_flutter/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_companies_profile.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_historical_stock.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/companies_profile_bloc.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/stock_bloc.dart';

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
  serviceLocator.registerLazySingleton<GetCompaniesProfileUsecase>(() {
    return GetCompaniesProfileUsecase(repository: serviceLocator());
  });
  serviceLocator.registerLazySingleton<GetHistoricalStockUsecase>(() {
    return GetHistoricalStockUsecase(repository: serviceLocator());
  });
  // blocs
  serviceLocator.registerFactory<CompaniesProfileBloc>(() {
    return CompaniesProfileBloc(getCompaniesProfileUsecase: serviceLocator());
  });
  serviceLocator.registerFactory<StockBloc>(() {
    return StockBloc(getHistoricalStockUsecase: serviceLocator());
  });
}
