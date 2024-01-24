import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/features/news/domain/usecases/get_top_headlines_usecase.dart';
import 'package:stock_news_flutter/features/news/presentation/blocs/news_bloc.dart';

import '../../../../fixtures/news_fixtures.dart';
import 'news_bloc_test.mocks.dart';

@GenerateMocks([GetTopHeadlinesUsecase])
void main() {
  late NewsBloc bloc;
  late MockGetTopHeadlinesUsecase mockGetTopHeadlinesUsecase;

  const tNewsEntities = NewsFixtures.newsEntities;
  const tServerFailure = ServerFailure('Server Failure');

  setUp(() {
    mockGetTopHeadlinesUsecase = MockGetTopHeadlinesUsecase();
    bloc = NewsBloc(getTopHeadlinesUsecase: mockGetTopHeadlinesUsecase);
  });

  tearDown(() {
    reset(mockGetTopHeadlinesUsecase);
  });

  group('LoadTopHeadlinesNewsEvent', () {
    blocTest<NewsBloc, NewsState>(
      'should emit [LoadedGreetingState] when the usecase returns a value',
      setUp: () {
        when(mockGetTopHeadlinesUsecase(any))
            .thenAnswer((_) async => const Right(tNewsEntities));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadTopHeadlinesNewsEvent()),
      expect: () => [const LoadedNewsState(news: tNewsEntities)],
    );

    blocTest<NewsBloc, NewsState>(
      'should emit [ErrorNewsState] when the usecase returns a [Failure]',
      setUp: () {
        when(mockGetTopHeadlinesUsecase(any))
            .thenAnswer((_) async => const Left(tServerFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadTopHeadlinesNewsEvent()),
      expect: () => [ErrorNewsState(message: tServerFailure.message)],
    );
  });
}
