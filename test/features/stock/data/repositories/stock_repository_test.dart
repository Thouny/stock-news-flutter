import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/network/models/get_company_profile_response_model.dart';
import 'package:stock_news_flutter/core/network/models/get_historical_stock_response_model.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/features/stock/data/datasources/stock_remote_datasource.dart';
import 'package:stock_news_flutter/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';

import 'stock_repository_test.mocks.dart';

@GenerateMocks([StockRemoteDataSource, ConnectionService])
void main() {
  late StockRepository repository;
  late MockStockRemoteDataSource mockRemoteDataSource;
  late MockConnectionService mockConnectionService;

  const tHistoricalDataModels = [
    HistoricalDataModel(
      date: "2024-01-18",
      open: 186.09,
      high: 189.14,
      low: 185.83,
      close: 188.63,
      adjClose: 188.63,
      volume: 77500694,
      unadjustedVolume: 77082288,
      change: 2.54,
      changePercent: 1.36,
      vwap: 187.93,
      label: "January 18, 24",
      changeOverTime: 0.0136,
    )
  ];

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
  const tCompanyEntities = StockConsts.companyWatchlist;

  final tStockEntities = [
    StockEntity(
      date: DateTime(2024, 01, 18),
      open: 186.09,
      high: 189.14,
      low: 185.83,
      close: 188.63,
      adjClose: 188.63,
      volume: 77500694,
      unadjustedVolume: 77082288,
      change: 2.54,
      changePercent: 1.36,
      vwap: 187.93,
      label: "January 18, 24",
      changeOverTime: 0.0136,
    ),
  ];

  const tServerException =
      ServerException('Server responded with an error code');
  const tNoConnectionFailure = NoConnectionFailure('No Connection');
  const tServerFailure = ServerFailure('Server responded with an error code');
  const tSymbol = 'AAPL';
  final tFrom = DateTime(2024, 01, 18);
  final tTo = DateTime(2024, 01, 21);

  setUp(() {
    mockRemoteDataSource = MockStockRemoteDataSource();
    mockConnectionService = MockConnectionService();
    repository = StockRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      connectionService: mockConnectionService,
    );
  });

  group('getHistoricalStock', () {
    test('should return a list of [StockEntity] when connection is available',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      )).thenAnswer((_) async => tHistoricalDataModels);
      // act
      final resultEither = await repository.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      );
      final result = resultEither.getOrElse(() => throw Exception());
      // assert
      expect(result, tStockEntities);
    });

    test('should return [ServerFailure] when repo throws [ServerException]',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      )).thenThrow(tServerException);
      // act
      final resultEither = await repository.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      );
      // assert
      expect(resultEither, const Left(tServerFailure));
    });

    test('should return [NoConnectionFailure] when connection is not available',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => false);
      // act
      final resultEither = await repository.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      );
      // assert
      expect(resultEither, const Left(tNoConnectionFailure));
    });
  });

  group('getCompaniesProfile', () {
    test('should return a list of [CompanyEntity] when connection is available',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCompanyProfile(any))
          .thenAnswer((_) async => tGetCompanyProfileResponseModel);
      // act
      final resultEither = await repository.getCompaniesProfile(
        [tSymbol],
      );
      final result = resultEither.getOrElse(() => throw Exception());
      // assert
      expect(result, tCompanyEntities);
    });

    test('should return [ServerFailure] when repo throws [ServerException]',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      )).thenThrow(tServerException);
      // act
      final resultEither = await repository.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      );
      // assert
      expect(resultEither, const Left(tServerFailure));
    });

    test('should return [NoConnectionFailure] when connection is not available',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => false);
      // act
      final resultEither = await repository.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      );
      // assert
      expect(resultEither, const Left(tNoConnectionFailure));
    });
  });
}
