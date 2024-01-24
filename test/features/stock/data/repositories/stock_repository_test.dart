import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/features/stock/data/datasources/stock_remote_datasource.dart';
import 'package:stock_news_flutter/features/stock/data/repositories/stock_repository_impl.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';

import '../../../../fixtures/stock_fixtures.dart';
import 'stock_repository_test.mocks.dart';

@GenerateMocks([StockRemoteDataSource, ConnectionService])
void main() {
  late StockRepository repository;
  late MockStockRemoteDataSource mockRemoteDataSource;
  late MockConnectionService mockConnectionService;

  const tHistoricalDataModels = StockFixtures.historicalDataModels;
  const tGetCompanyProfileResponseModel =
      StockFixtures.getCompanyProfileResponseModel;
  const tCompanyEntities = StockFixtures.companiesProfileEntities;
  final tStockEntities = StockFixtures.stockEntities;
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
