import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/features/news/data/datasource/news_remote_datasource.dart';
import 'package:stock_news_flutter/features/news/data/repositories/news_repository_impl.dart';
import 'package:stock_news_flutter/features/news/domain/repositories/news_repository.dart';

import '../../../../fixtures/news_fixtures.dart';
import 'news_repository_test.mocks.dart';

@GenerateMocks([NewsRemoteDataSource, ConnectionService])
void main() {
  late NewsRepository repository;
  late MockNewsRemoteDataSource mockRemoteDataSource;
  late MockConnectionService mockConnectionService;

  final tModels = NewsFixtures.getNewsResponseModel.articles;
  const tEntities = NewsFixtures.newsEntities;
  const tServerException =
      ServerException('Server responded with an error code');
  const tNoConnectionFailure = NoConnectionFailure('No Connection');
  const tServerFailure = ServerFailure('Server responded with an error code');

  setUp(() {
    mockRemoteDataSource = MockNewsRemoteDataSource();
    mockConnectionService = MockConnectionService();
    repository = NewsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      connectionService: mockConnectionService,
    );
  });

  group('getTopHeadlines', () {
    test('should return a list of [NewsEntity] when connection is available',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopHeadlines())
          .thenAnswer((_) async => tModels);
      // act
      final resultEither = await repository.getTopHeadlines();
      final result = resultEither.getOrElse(() => throw Exception());
      // assert
      expect(result, tEntities);
    });

    test('should return [ServerFailure] when repo throws [ServerException]',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTopHeadlines()).thenThrow(tServerException);
      // act
      final resultEither = await repository.getTopHeadlines();
      // assert
      expect(resultEither, const Left(tServerFailure));
    });

    test('should return [NoConnectionFailure] when connection is not available',
        () async {
      // arrange
      when(mockConnectionService.isConnected).thenAnswer((_) async => false);
      // act
      final resultEither = await repository.getTopHeadlines();
      // assert
      expect(resultEither, const Left(tNoConnectionFailure));
    });
  });
}
