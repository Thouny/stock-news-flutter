import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/features/user/domain/usecases/get_greeting_usecase.dart';

void init(GetIt serviceLocator) {
  // usecase
  serviceLocator.registerLazySingleton<GetGreetingUsecase>(() {
    return GetGreetingUsecase(clock: serviceLocator());
  });
}
