import 'package:stock_news_flutter/core/network/models/get_news_response_model.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';

class NewsFixtures {
  const NewsFixtures._();

  static const getNewsResponseModel = GetNewsResponseModel(
    status: 'ok',
    totalResults: 0,
    articles: [
      ArticleModel(
        title: 'title',
        description: 'description',
        url: 'url',
        urlToImage: 'urlToImage',
        publishedAt: '',
        content: 'content',
        source: SourceModel(id: 'id', name: 'name'),
        author: '',
      )
    ],
  );

  static const newsEntities = [
    NewsEntity(
      title: 'title',
      description: 'description',
      url: 'url',
      urlToImage: 'urlToImage',
      publishedAt: '',
      content: 'content',
      source: Source(id: 'id', name: 'name'),
      author: '',
    ),
  ];
}
