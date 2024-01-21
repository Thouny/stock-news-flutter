import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/core/network/api/financial_modeling_prep_http_client.dart';
import 'package:stock_news_flutter/core/network/api/news_http_client.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/core/storage/secure_storage.dart';
import 'package:stock_news_flutter/core/utils/clock.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';

import 'news.dart' as news;
import 'stock.dart' as stock;
import 'user.dart' as user;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  /* Features =============================================================== */
  news.init(serviceLocator);
  stock.init(serviceLocator);
  user.init(serviceLocator);
  /* ======================================================================== */
  /* Core =================================================================== */
  serviceLocator.registerLazySingleton(() => const Clock());
  serviceLocator.registerLazySingleton<ConnectionService>(() {
    return ConnectionServiceImpl(serviceLocator<Connectivity>());
  });
  // link handler
  serviceLocator.registerFactory<LinkHandler>(() => const LinkHandlerImpl());
  // financial modeling prep http client
  serviceLocator.registerLazySingleton(() {
    return FinancialModelingPrepHttpClient(serviceLocator());
  });
  // news http client
  serviceLocator.registerLazySingleton(() {
    return NewsHttpClient(serviceLocator());
  });
  serviceLocator.registerLazySingleton<SecureStorage>(() {
    return SecureStorage(serviceLocator());
  });
  /* ======================================================================== */
  /* Third-party ============================================================ */
  // connection
  serviceLocator.registerLazySingleton(() => Connectivity());
  // dio
  serviceLocator.registerLazySingleton(() => BaseOptions());
  serviceLocator.registerLazySingleton(() => Dio(serviceLocator()));
  // flutter secure storage
  serviceLocator.registerLazySingleton<FlutterSecureStorage>(() {
    return const FlutterSecureStorage();
  });
  /* ======================================================================== */
}
