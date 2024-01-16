import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:stock_news_flutter/features/news/domain/usecases/get_top_headlines_usecase.dart';

import 'get_top_headlines_usecase_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late GetTopHeadlinesUsecase usecase;
  late MockNewsRepository mockNewsRepository;

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

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    usecase = GetTopHeadlinesUsecase(repository: mockNewsRepository);
  });

  tearDown(() {
    reset(mockNewsRepository);
  });

  test('should forward the call to the repository', () async {
    // arrange
    when(mockNewsRepository.getTopHeadlines())
        .thenAnswer((_) async => const Right([tNewsEntity]));
    // act
    final result = await usecase(const NoParams());
    // assert
    expect(result, const Right([tNewsEntity]));
    verify(mockNewsRepository.getTopHeadlines());
    verifyNoMoreInteractions(mockNewsRepository);
  });
}
