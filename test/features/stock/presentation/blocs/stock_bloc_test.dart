import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_historical_stock.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/stock_bloc.dart';

import 'stock_bloc_test.mocks.dart';

@GenerateMocks([GetHistoricalStockUsecase])
void main() {
  late StockBloc bloc;
  late MockGetHistoricalStockUsecase mockGetHistoricalStockUsecase;

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
    )
  ];

  const tServerFailure = ServerFailure('Server Failure');

  setUp(() {
    mockGetHistoricalStockUsecase = MockGetHistoricalStockUsecase();
    bloc = StockBloc(getHistoricalStockUsecase: mockGetHistoricalStockUsecase);
  });

  tearDown(() {
    reset(mockGetHistoricalStockUsecase);
  });

  group('LoadedStockState', () {
    blocTest<StockBloc, StockState>(
      'should emit [LoadedStockState] when the usecase returns a value',
      setUp: () {
        when(mockGetHistoricalStockUsecase(any))
            .thenAnswer((_) async => Right(tStockEntities));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(LoadHistoricalStockEvent(
        symbol: 'AAPL',
        from: DateTime(2024, 01, 18),
        to: DateTime(2024, 01, 18),
      )),
      expect: () => [
        const LoadingStockState(),
        LoadedStockState(stocks: tStockEntities),
      ],
    );

    blocTest<StockBloc, StockState>(
      'should emit [ErrorStockState] when the usecase returns a [Failure]',
      setUp: () {
        when(mockGetHistoricalStockUsecase(any))
            .thenAnswer((_) async => const Left(tServerFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(LoadHistoricalStockEvent(
        symbol: 'AAPL',
        from: DateTime(2024, 01, 18),
        to: DateTime(2024, 01, 18),
      )),
      expect: () => [
        const LoadingStockState(),
        ErrorStockState(message: tServerFailure.message)
      ],
    );
  });
}
