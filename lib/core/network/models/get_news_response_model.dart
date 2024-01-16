import 'package:json_annotation/json_annotation.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';

part 'get_news_response_model.g.dart';

@JsonSerializable()
class GetNewsResponseModel {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  GetNewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory GetNewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetNewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetNewsResponseModelToJson(this);
}

@JsonSerializable()
class ArticleModel {
  final SourceModel source;
  final String author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  NewsEntity get toEntity {
    return NewsEntity(
      source: Source(id: source.id ?? "", name: source.name),
      author: author,
      title: title,
      description: description ?? "",
      url: url,
      urlToImage: urlToImage ?? "",
      publishedAt: publishedAt,
      content: content ?? "",
    );
  }
}

@JsonSerializable()
class SourceModel {
  final String? id;
  final String name;

  SourceModel({
    this.id,
    required this.name,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}
