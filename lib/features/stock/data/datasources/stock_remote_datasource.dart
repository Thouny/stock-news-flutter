import 'package:stock_news_flutter/core/enums/storage_keys.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/extension/date_time.dart';
import 'package:stock_news_flutter/core/network/api/financial_modeling_prep_http_client.dart';
import 'package:stock_news_flutter/core/network/models/get_historical_stock_response_model.dart';
import 'package:stock_news_flutter/core/storage/secure_storage.dart';

abstract class StockRemoteDataSource {
  Future<List<HistoricalDataModel>> getHistoricalStock(
    String symbol,
    DateTime from,
    DateTime to,
  );
}

class StockRemoteDataSourceImpl implements StockRemoteDataSource {
  final FinancialModelingPrepHttpClient _client;
  final SecureStorage _storage;

  StockRemoteDataSourceImpl({
    required FinancialModelingPrepHttpClient client,
    required SecureStorage storage,
  })  : _client = client,
        _storage = storage;

  @override
  Future<List<HistoricalDataModel>> getHistoricalStock(
    String symbol,
    DateTime from,
    DateTime to,
  ) async {
    final key = StorageKeys.financialModelingPrepApiKey.name;
    final apiKey = await _storage.read<String>(key) ?? "";
    if (apiKey.isEmpty) throw const StorageException("API key not found");

    final response = await _client.getHistoricalStockData(
      symbol,
      from.toDateString,
      to.toDateString,
      apiKey,
    );
    if (response.response.statusCode != 200) {
      throw const ServerException('Server responded with an error code');
    }
    return response.data.historical.map((e) => e).toList();
  }
}
