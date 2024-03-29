import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stock_news_flutter/core/network/models/get_company_profile_response_model.dart';
import 'package:stock_news_flutter/core/network/models/get_historical_stock_response_model.dart';

part 'financial_modeling_prep_http_client.g.dart';

@RestApi(baseUrl: 'https://financialmodelingprep.com/api/v3/')
abstract class FinancialModelingPrepHttpClient {
  factory FinancialModelingPrepHttpClient(Dio dio, {String baseUrl}) =
      _FinancialModelingPrepHttpClient;

  @GET('/historical-price-full/{symbol}')
  Future<HttpResponse<GetHistoricalStockResponseModel>> getHistoricalStockData(
    @Path('symbol') String symbol,
    @Query('from') String from,
    @Query('to') String to,
    @Query('apikey') String apiKey,
  );

  @GET('/profile/{symbol}')
  Future<HttpResponse<List<GetCompanyProfileResponseModel>>> getCompanyProfile(
    @Path('symbol') String symbol,
    @Query('apikey') String apiKey,
  );
}
