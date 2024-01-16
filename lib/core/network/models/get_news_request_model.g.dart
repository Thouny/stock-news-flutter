// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_news_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNewsRequestModel _$GetNewsRequestModelFromJson(Map<String, dynamic> json) =>
    GetNewsRequestModel(
      apiKey: json['apiKey'] as String,
      country: json['country'] as String?,
      category: json['category'] as String?,
      sources: json['sources'] as String?,
      q: json['q'] as String?,
      pageSize: json['pageSize'] as int?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$GetNewsRequestModelToJson(
        GetNewsRequestModel instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'country': instance.country,
      'category': instance.category,
      'sources': instance.sources,
      'q': instance.q,
      'pageSize': instance.pageSize,
      'page': instance.page,
    };
