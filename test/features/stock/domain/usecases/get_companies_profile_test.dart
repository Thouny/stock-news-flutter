import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_companies_profile.dart';

import '../../../../fixtures/stock_fixtures.dart';
import 'get_historical_stock_usecase_test.mocks.dart';

@GenerateMocks([StockRepository])
void main() {
  late GetCompaniesProfileUsecase usecase;
  late MockStockRepository mockStockRepository;

  const tGetCompaniesProfileParams = GetCompaniesProfileParams(
    symbols: ['AAPL'],
  );

  const tCompanyEntities = StockFixtures.companiesProfileEntities;

  setUp(() {
    mockStockRepository = MockStockRepository();
    usecase = GetCompaniesProfileUsecase(repository: mockStockRepository);
  });

  tearDown(() {
    reset(mockStockRepository);
  });

  test('should forward the call to the repository', () async {
    // arrange
    when(mockStockRepository.getCompaniesProfile(
      tGetCompaniesProfileParams.symbols,
    )).thenAnswer((_) async => const Right(tCompanyEntities));
    // act
    final result = await usecase(tGetCompaniesProfileParams);
    // assert
    expect(result, equals(const Right(tCompanyEntities)));
    verify(mockStockRepository.getCompaniesProfile(
      tGetCompaniesProfileParams.symbols,
    ));
    verifyNoMoreInteractions(mockStockRepository);
  });
}
