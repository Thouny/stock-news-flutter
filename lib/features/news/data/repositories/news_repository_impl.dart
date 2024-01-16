import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/features/news/data/datasource/news_remote_datasource.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final ConnectionService connectionService;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionService,
  });

  @override
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlines() async {
    try {
      if (!await connectionService.isConnected) {
        return const Left(NoConnectionFailure());
      }

      final newsModels = await remoteDataSource.getTopHeadlines();
      final newsEntities = newsModels.map((model) => model.toEntity).toList();
      return Right(newsEntities);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (error) {
      return Left(NetworkFailure(message: error.toString()));
    }
  }
}
