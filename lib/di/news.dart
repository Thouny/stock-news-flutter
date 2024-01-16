import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/features/news/domain/usecases/get_top_headlines_usecase.dart';

void init(GetIt serviceLocator) {
  // usecase
  serviceLocator.registerLazySingleton<GetTopHeadlinesUsecase>(() {
    return GetTopHeadlinesUsecase(repository: serviceLocator());
  });
}
