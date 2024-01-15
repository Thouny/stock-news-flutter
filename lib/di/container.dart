import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/core/utils/clock.dart';

import 'user.dart' as user;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  user.init(serviceLocator);
  serviceLocator.registerLazySingleton(() => const Clock());
}
