import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/domain/repositories/news_repository.dart';

class GetTopHeadlinesUsecase extends Usecase<List<NewsEntity>, NoParams> {
  final NewsRepository repository;

  GetTopHeadlinesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<NewsEntity>>> call(NoParams params) async {
    return await repository.getTopHeadlines();
  }
}
