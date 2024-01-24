import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_companies_profile.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/companies_profile_bloc.dart';

import '../../../../fixtures/stock_fixtures.dart';
import 'companies_profile_bloc_test.mocks.dart';

@GenerateMocks([GetCompaniesProfileUsecase])
void main() {
  late CompaniesProfileBloc bloc;
  late MockGetCompaniesProfileUsecase mockGetCompaniesProfileUsecase;

  const tCompanyEntities = StockFixtures.companiesProfileEntities;
  const tSymbol = 'AAPL';
  const tServerFailure = ServerFailure('Server Failure');

  setUp(() {
    mockGetCompaniesProfileUsecase = MockGetCompaniesProfileUsecase();
    bloc = CompaniesProfileBloc(
      getCompaniesProfileUsecase: mockGetCompaniesProfileUsecase,
    );
  });

  tearDown(() {
    reset(mockGetCompaniesProfileUsecase);
  });

  group('LoadCompaniesProfileEvent', () {
    blocTest<CompaniesProfileBloc, CompaniesProfileState>(
      'should emit [LoadedCompaniesProfileState] when the usecase return a value',
      setUp: () {
        when(mockGetCompaniesProfileUsecase(any))
            .thenAnswer((_) async => const Right(tCompanyEntities));
      },
      build: () => bloc,
      act: (bloc) {
        return bloc.add(const LoadCompaniesProfileEvent(symbols: [tSymbol]));
      },
      expect: () {
        return [
          const LoadingCompaniesProfileState(),
          const LoadedCompaniesProfileState(companies: tCompanyEntities),
        ];
      },
    );

    blocTest<CompaniesProfileBloc, CompaniesProfileState>(
      'should emit [ErrorCompaniesProfileState] when the usecase returns a [Failure]',
      setUp: () {
        when(mockGetCompaniesProfileUsecase(any))
            .thenAnswer((_) async => const Left(tServerFailure));
      },
      build: () => bloc,
      act: (bloc) {
        return bloc.add(const LoadCompaniesProfileEvent(symbols: [tSymbol]));
      },
      expect: () {
        return [
          const LoadingCompaniesProfileState(),
          ErrorCompaniesProfileState(message: tServerFailure.message)
        ];
      },
    );
  });
}
