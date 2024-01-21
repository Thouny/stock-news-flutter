import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
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

  const tModels = [
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
  final tEntities = [
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
    test('should return a list of StockEntity when connection is available',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      )).thenAnswer((_) async => tModels);
      // act
      final resultEither = await repository.getHistoricalStock(
        tSymbol,
        tFrom,
        tTo,
      );
      final result = resultEither.getOrElse(() => throw Exception());
      // assert
      expect(result, tEntities);
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
