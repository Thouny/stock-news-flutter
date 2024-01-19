import 'package:stock_news_flutter/core/enums/storage_keys.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/network/api/news_http_client.dart';
import 'package:stock_news_flutter/core/network/models/get_news_response_model.dart';
import 'package:stock_news_flutter/core/storage/secure_storage.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final NewsHttpClient _client;
  final SecureStorage _storage;

  NewsRemoteDataSourceImpl({
    required NewsHttpClient client,
    required SecureStorage storage,
  })  : _client = client,
        _storage = storage;

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    final key = StorageKeys.newsApiKey.name;
    final apiKey = await _storage.read<String>(key) ?? "";
    if (apiKey.isEmpty) throw const StorageException("API key not found");
    final response = await _client.getTopHeadlines(apiKey, 'business', 'au');
    if (response.status != "ok") {
      throw const ServerException('Server responded with an error code');
    }
    return response.articles;
  }
}
