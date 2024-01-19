import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stock_news_flutter/core/network/models/get_news_response_model.dart';

part 'news_http_client.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
abstract class NewsHttpClient {
  factory NewsHttpClient(Dio dio, {String baseUrl}) = _NewsHttpClient;

  @GET('/top-headlines')
  Future<GetNewsResponseModel> getTopHeadlines(
    @Query('apiKey') String apiKey,
    @Query('category') String category,
    @Query('country') String country,
  );
}
