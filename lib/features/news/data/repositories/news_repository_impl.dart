import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/features/news/data/datasource/news_remote_datasource.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remoteDataSource;
  final ConnectionService _connectionService;

  NewsRepositoryImpl({
    required NewsRemoteDataSource remoteDataSource,
    required ConnectionService connectionService,
  })  : _remoteDataSource = remoteDataSource,
        _connectionService = connectionService;

  @override
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlines() async {
    try {
      if (!await _connectionService.isConnected) {
        return const Left(NoConnectionFailure('No Connection'));
      }

      final newsModels = await _remoteDataSource.getTopHeadlines();
      final newsEntities = newsModels.map((model) => model.toEntity).toList();
      return Right(newsEntities);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
