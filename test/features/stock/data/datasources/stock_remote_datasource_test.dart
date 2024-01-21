import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stock_news_flutter/core/enums/storage_keys.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/extension/date_time.dart';
import 'package:stock_news_flutter/core/network/api/financial_modeling_prep_http_client.dart';
import 'package:stock_news_flutter/core/network/models/get_historical_stock_response_model.dart';
import 'package:stock_news_flutter/core/storage/secure_storage.dart';
import 'package:stock_news_flutter/features/stock/data/datasources/stock_remote_datasource.dart';

import 'stock_remote_datasource_test.mocks.dart';

@GenerateMocks([FinancialModelingPrepHttpClient, SecureStorage])
void main() {
  late StockRemoteDataSource dataSource;
  late MockFinancialModelingPrepHttpClient mockClient;
  late MockSecureStorage mockStorage;

  const tApiKey = 'testApiKey';
  const tSymbol = 'AAPL';
  const tResponse = GetHistoricalStockResponseModel(
    symbol: tSymbol,
    historical: [],
  );

  final tKey = StorageKeys.financialModelingPrepApiKey.name;
  final tFrom = DateTime(2024, 01, 18);
  final tTo = DateTime(2024, 01, 21);

  setUp(() {
    mockClient = MockFinancialModelingPrepHttpClient();
    mockStorage = MockSecureStorage();
    dataSource = StockRemoteDataSourceImpl(
      client: mockClient,
      storage: mockStorage,
    );
  });

  group('getHistoricalStock', () {
    test('should throw [StorageException] when API key is not found in storage',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => null);
      // act
      final call = dataSource.getHistoricalStock;
      // assert
      expect(call(tSymbol, tFrom, tTo), throwsA(isA<StorageException>()));
    });

    test('should throw [ServerException] when the network request fails',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getHistoricalStockData(
        tSymbol,
        tFrom.toDateString,
        tTo.toDateString,
        'line',
        tApiKey,
      )).thenThrow(
        const ServerException('Server responded with an error code'),
      );
      // act
      final call = dataSource.getHistoricalStock;
      // assert
      expect(call(tSymbol, tFrom, tTo), throwsA(isA<ServerException>()));
    });

    test('should throw [Exception] when an unexpected error occurs', () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getHistoricalStockData(
        tSymbol,
        tFrom.toDateString,
        tTo.toDateString,
        'line',
        tApiKey,
      )).thenThrow(Exception());
      // act
      final call = dataSource.getHistoricalStock;
      // assert
      expect(call(tSymbol, tFrom, tTo), throwsA(isA<Exception>()));
    });

    test('should make successful network request and return historical data',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getHistoricalStockData(
        tSymbol,
        tFrom.toDateString,
        tTo.toDateString,
        'line',
        tApiKey,
      )).thenAnswer((_) async => HttpResponse(tResponse,
          Response(requestOptions: RequestOptions(), statusCode: 200)));
      // act
      final result = await dataSource.getHistoricalStock(tSymbol, tFrom, tTo);
      // assert
      verify(mockStorage.read<String>(tKey));
      expect(result, tResponse.historical);
    });
  });
}
