import 'package:json_annotation/json_annotation.dart';

part 'get_news_request_model.g.dart';

@JsonSerializable()
class GetNewsRequestModel {
  final String apiKey;
  final String? country;
  final String? category;
  final String? sources;
  final String? q;
  final int? pageSize;
  final int? page;

  GetNewsRequestModel({
    required this.apiKey,
    this.country,
    this.category,
    this.sources,
    this.q,
    this.pageSize,
    this.page,
  });
}
