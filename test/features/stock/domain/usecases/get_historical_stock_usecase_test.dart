import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_historical_stock.dart';

import 'get_historical_stock_usecase_test.mocks.dart';

@GenerateMocks([StockRepository])
void main() {
  late GetHistoricalStockUsecase usecase;
  late MockStockRepository mockStockRepository;

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

  final tGetHistoricalStockParams = GetHistoricalStockParams(
    symbol: 'AAPL',
    from: DateTime(2024, 01, 18),
    to: DateTime(2024, 01, 18),
  );

  setUp(() {
    mockStockRepository = MockStockRepository();
    usecase = GetHistoricalStockUsecase(repository: mockStockRepository);
  });

  tearDown(() {
    reset(mockStockRepository);
  });

  test('should forward the call to the repository', () async {
    // arrange
    when(mockStockRepository.getHistoricalStock(
      tGetHistoricalStockParams.symbol,
      tGetHistoricalStockParams.from,
      tGetHistoricalStockParams.to,
    )).thenAnswer((_) async => Right(tStockEntities));
    // act
    final result = await usecase(tGetHistoricalStockParams);
    // assert
    expect(result, equals(Right(tStockEntities)));
    verify(mockStockRepository.getHistoricalStock(
      tGetHistoricalStockParams.symbol,
      tGetHistoricalStockParams.from,
      tGetHistoricalStockParams.to,
    ));
    verifyNoMoreInteractions(mockStockRepository);
  });
}
