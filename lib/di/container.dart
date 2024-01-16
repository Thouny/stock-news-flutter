import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/core/network/api/news_http_client.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/core/storage/secure_storage.dart';
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
  serviceLocator.registerLazySingleton<SecureStorage>(() {
    return SecureStorage(storage: serviceLocator());
  });
  /* ======================================================================== */

  /* Third-party ============================================================ */
  // dio
  serviceLocator.registerLazySingleton(() {
    return BaseOptions(contentType: 'application/json');
  });
  serviceLocator.registerLazySingleton(() => Dio(serviceLocator()));
  // flutter secure storage
  serviceLocator.registerLazySingleton(() => const FlutterSecureStorage());
  /* ======================================================================== */
}
