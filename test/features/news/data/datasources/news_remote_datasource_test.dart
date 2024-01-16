import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/enums/storage_keys.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/network/api/news_http_client.dart';
import 'package:stock_news_flutter/core/network/models/get_news_request_model.dart';
import 'package:stock_news_flutter/core/network/models/get_news_response_model.dart';
import 'package:stock_news_flutter/core/storage/secure_storage.dart';
import 'package:stock_news_flutter/features/news/data/datasource/news_remote_datasource.dart';

import 'news_remote_datasource_test.mocks.dart';

@GenerateMocks([NewsHttpClient, SecureStorage])
void main() {
  late NewsRemoteDataSource dataSource;
  late MockNewsHttpClient mockClient;
  late MockSecureStorage mockStorage;

  final tKey = StorageKeys.newsApiKey.name;
  const tApiKey = 'testApiKey';
  const tRequest = GetNewsRequestModel(apiKey: tApiKey);
  const tResponse = GetNewsResponseModel(
    status: 'ok',
    totalResults: 0,
    articles: [],
  );

  setUp(() {
    mockClient = MockNewsHttpClient();
    mockStorage = MockSecureStorage();
    dataSource = NewsRemoteDataSourceImpl(
      client: mockClient,
      storage: mockStorage,
    );
  });

  group('getTopHeadlines', () {
    test(
        'should get API key from storage and make a successful network request',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getTopHeadlines(request: tRequest))
          .thenAnswer((_) async => tResponse);
      // act
      final result = await dataSource.getTopHeadlines();
      // assert
      verify(mockStorage.read<String>(tKey));
      verify(mockClient.getTopHeadlines(request: tRequest));
      expect(result, tResponse.articles);
    });

    test('should throw [StorageException] when API key is not found in storage',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => null);
      // act
      final call = dataSource.getTopHeadlines;
      // assert
      expect(call(), throwsA(isA<StorageException>()));
    });

    test('should throw [ServerException] when the network request fails',
        () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getTopHeadlines(request: tRequest)).thenThrow(
        const ServerException('Server responded with an error code'),
      );
      // act
      final call = dataSource.getTopHeadlines;
      // assert
      expect(call(), throwsA(isA<ServerException>()));
    });

    test('should throw [Exception] when an unexpected error occurs', () async {
      // arrange
      when(mockStorage.read<String>(tKey)).thenAnswer((_) async => tApiKey);
      when(mockClient.getTopHeadlines(request: tRequest))
          .thenThrow(Exception());
      // act
      final call = dataSource.getTopHeadlines;
      // assert
      expect(call(), throwsA(isA<Exception>()));
    });
  });
}
