import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/domain/usecases/get_top_headlines_usecase.dart';
import 'package:stock_news_flutter/features/news/presentation/bloc/news_bloc.dart';

import 'news_bloc_test.mocks.dart';

@GenerateMocks([GetTopHeadlinesUsecase])
void main() {
  late NewsBloc bloc;
  late MockGetTopHeadlinesUsecase mockGetTopHeadlinesUsecase;

  const tNewsEntity = NewsEntity(
    title: 'title',
    description: 'description',
    url: 'url',
    urlToImage: 'urlToImage',
    publishedAt: '',
    content: 'content',
    source: Source(id: 'id', name: 'name'),
    author: '',
  );

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
            .thenAnswer((_) async => const Right([tNewsEntity]));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadTopHeadlinesNewsEvent()),
      expect: () => [
        const LoadingNewsState(),
        const LoadedNewsState(news: [tNewsEntity])
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'should emit [ErrorNewsState] when the usecase returns a [Failure]',
      setUp: () {
        when(mockGetTopHeadlinesUsecase(any))
            .thenAnswer((_) async => const Left(tServerFailure));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadTopHeadlinesNewsEvent()),
      expect: () => [
        const LoadingNewsState(),
        ErrorNewsState(message: tServerFailure.message)
      ],
    );
  });
}
