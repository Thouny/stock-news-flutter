import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/features/news/data/datasource/news_remote_datasource.dart';
import 'package:stock_news_flutter/features/news/data/repositories/news_repository_impl.dart';
import 'package:stock_news_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:stock_news_flutter/features/news/domain/usecases/get_top_headlines_usecase.dart';
import 'package:stock_news_flutter/features/news/presentation/bloc/news_bloc.dart';

void init(GetIt serviceLocator) {
  // data sources
  serviceLocator.registerLazySingleton<NewsRemoteDataSource>(() {
    return NewsRemoteDataSourceImpl(
      client: serviceLocator(),
      storage: serviceLocator(),
    );
  });
  // repositories
  serviceLocator.registerLazySingleton<NewsRepository>(() {
    return NewsRepositoryImpl(
      connectionService: serviceLocator(),
      remoteDataSource: serviceLocator(),
    );
  });
  // usecases
  serviceLocator.registerLazySingleton<GetTopHeadlinesUsecase>(() {
    return GetTopHeadlinesUsecase(repository: serviceLocator());
  });
  // blocs
  serviceLocator.registerFactory<NewsBloc>(() {
    return NewsBloc(getTopHeadlinesUsecase: serviceLocator());
  });
}
