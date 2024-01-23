import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:stock_news_flutter/features/news/domain/usecases/get_top_headlines_usecase.dart';

import '../../../../fixtures/news_fixtures.dart';
import 'get_top_headlines_usecase_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late GetTopHeadlinesUsecase usecase;
  late MockNewsRepository mockNewsRepository;

  const tNewsEntities = NewsFixtures.newsEntities;

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
        .thenAnswer((_) async => const Right(tNewsEntities));
    // act
    final result = await usecase(const NoParams());
    // assert
    expect(result, const Right(tNewsEntities));
    verify(mockNewsRepository.getTopHeadlines());
    verifyNoMoreInteractions(mockNewsRepository);
  });
}
