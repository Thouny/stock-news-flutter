import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_news_request_model.g.dart';

@JsonSerializable()
class GetNewsRequestModel extends Equatable {
  final String apiKey;
  final String? country;
  final String? category;
  final String? sources;
  final String? q;
  final int? pageSize;
  final int? page;

  const GetNewsRequestModel({
    required this.apiKey,
    this.country,
    this.category,
    this.sources,
    this.q,
    this.pageSize,
    this.page,
  });

  factory GetNewsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GetNewsRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetNewsRequestModelToJson(this);

  @override
  List<Object?> get props => [
        apiKey,
        country,
        category,
        sources,
        q,
        pageSize,
        page,
      ];
}
