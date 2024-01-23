import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stock_news_flutter/core/enums/storage_keys.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/extension/date_time.dart';
import 'package:stock_news_flutter/core/network/api/financial_modeling_prep_http_client.dart';
import 'package:stock_news_flutter/core/network/models/get_company_profile_response_model.dart';
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
  const tGetHistoricalStockResponse = GetHistoricalStockResponseModel(
    symbol: tSymbol,
    historical: [],
  );
  const tGetCompanyProfileResponseModel = GetCompanyProfileResponseModel(
    companyName: 'Apple Inc.',
    symbol: 'AAPL',
    currency: 'USD',
    exchange: 'NASDAQ Global Select',
    exchangeShortName: 'NASDAQ',
    price: 178.72,
    beta: 1.286802,
    volAvg: 58405568,
    mktCap: 2794144143933,
    lastDiv: 0.96,
    range: '124.17-198.23',
    changes: -0.13,
    cik: '0000320193',
    isin: 'US0378331005',
    cusip: '037833100',
    industry: 'Consumer Electronics',
    website: 'https://www.apple.com',
    description:
        'Apple Inc. designs, manufactures, and markets smartphones, personal computers,'
        ' tablets, wearables, and accessories worldwide. It also sells various related services.'
        ' In addition, the company offers iPhone, a line of smartphones; Mac, a line of personal computers; '
        'iPad, a line of multi-purpose tablets; AirPods Max, an over-ear wireless headphone; and wearables, home,'
        ' and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, HomePod, and iPod touch. '
        'Further, it provides AppleCare support services; cloud services store services; '
        'and operates various platforms, including the App Store that allow customers to discover '
        'and download applications and digital content, such as books, music, video, games, and podcasts. '
        'Additionally, the company offers various services, such as Apple Arcade, a game subscription service;'
        ' Apple Music, which offers users a curated listening experience with on-demand radio stations; '
        'Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; '
        'Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, '
        'as well as licenses its intellectual property. The company serves consumers,'
        ' and small and mid-sized businesses; and the education, enterprise, and government markets. '
        'It distributes third-party applications for its products through the App Store. '
        'The company also sells its products through its retail and online stores,'
        ' and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. '
        'Apple Inc. was incorporated in 1977 and is headquartered in Cupertino, California.',
    ceo: 'Mr. Timothy D. Cook',
    sector: 'Technology',
    country: '"',
    fullTimeEmployees: '164000',
    phone: '408 996 1010',
    address: 'One Apple Park Way',
    city: 'Cupertino',
    state: 'CA',
    zip: '95014',
    dcfDiff: 4.15176,
    dcf: 150.082,
    image: 'https://financialmodelingprep.com/image-stock/AAPL.png',
    ipoDate: '1980-12-12',
    defaultImage: false,
    isEtf: false,
    isActivelyTrading: true,
    isAdr: false,
    isFund: false,
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
        tApiKey,
      )).thenAnswer((_) async => HttpResponse(tGetHistoricalStockResponse,
          Response(requestOptions: RequestOptions(), statusCode: 200)));
      // act
      final result = await dataSource.getHistoricalStock(tSymbol, tFrom, tTo);
      // assert
      verify(mockStorage.read<String>(tKey));
      expect(result, tGetHistoricalStockResponse.historical);
    });
  });

  group('getCompanyProfile', () {
    test('should throw [StorageException] when API key is not found in storage',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => null);
      // act
      final call = dataSource.getCompanyProfile;
      // assert
      expect(call(tSymbol), throwsA(isA<StorageException>()));
    });

    test('should throw [ServerException] when the network request fails',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getCompanyProfile(tSymbol, tApiKey)).thenThrow(
        const ServerException('Server responded with an error code'),
      );
      // act
      final call = dataSource.getCompanyProfile;
      // assert
      expect(call(tSymbol), throwsA(isA<ServerException>()));
    });

    test('should throw [Exception] when an unexpected error occurs', () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getCompanyProfile(tSymbol, tApiKey))
          .thenThrow(Exception());
      // act
      final call = dataSource.getCompanyProfile;
      // assert
      expect(call(tSymbol), throwsA(isA<Exception>()));
    });

    test('should make successful network request and return historical data',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getCompanyProfile(tSymbol, tApiKey)).thenAnswer(
          (_) async => HttpResponse(tGetCompanyProfileResponseModel,
              Response(requestOptions: RequestOptions(), statusCode: 200)));
      // act
      final result = await dataSource.getCompanyProfile(tSymbol);
      // assert
      verify(mockStorage.read<String>(tKey));
      expect(result, tGetCompanyProfileResponseModel);
    });
  });
}
