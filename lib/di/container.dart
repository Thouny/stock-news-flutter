import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/core/network/api/news_http_client.dart';
import 'package:stock_news_flutter/core/network/connectivity_service.dart';
import 'package:stock_news_flutter/core/utils/clock.dart';

import 'user.dart' as user;
import 'news.dart' as news;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  /* Features =============================================================== */
  news.init(serviceLocator);
  user.init(serviceLocator);
  /* ======================================================================== */

  /* Core =================================================================== */
  serviceLocator.registerLazySingleton(() => const Clock());
  serviceLocator.registerLazySingleton(() {
    return ConnectionServiceImpl(Connectivity());
  });
  // news http client
  serviceLocator.registerLazySingleton(() {
    return NewsHttpClient(serviceLocator());
  });
  /* ======================================================================== */

  /* Third-party ============================================================ */
  // dio
  serviceLocator.registerLazySingleton(() {
    return BaseOptions(contentType: 'application/json');
  });
  serviceLocator.registerLazySingleton(() => Dio(serviceLocator()));
  /* ======================================================================== */
}
