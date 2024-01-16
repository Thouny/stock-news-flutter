import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/core/utils/clock.dart';

import 'user.dart' as user;
import 'news.dart' as news;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  news.init(serviceLocator);
  user.init(serviceLocator);
  serviceLocator.registerLazySingleton(() => const Clock());
}
