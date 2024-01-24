import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/exceptions.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/network/service/connectivity_service.dart';
import 'package:stock_news_flutter/features/stock/data/datasources/stock_remote_datasource.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final StockRemoteDataSource _remoteDataSource;
  final ConnectionService _connectionService;

  StockRepositoryImpl({
    required ConnectionService connectionService,
    required StockRemoteDataSource remoteDataSource,
  })  : _connectionService = connectionService,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<StockEntity>>> getHistoricalStock(
    String symbol,
    DateTime from,
    DateTime to,
  ) async {
    try {
      if (!await _connectionService.isConnected) {
        return const Left(NoConnectionFailure('No Connection'));
      }

      final stockModels = await _remoteDataSource.getHistoricalStock(
        symbol,
        from,
        to,
      );

      final stockEntities = stockModels.map((model) => model.toEntity).toList();
      return Right(stockEntities);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompaniesProfile(
    List<String> symbols,
  ) async {
    try {
      if (!await _connectionService.isConnected) {
        return const Left(NoConnectionFailure('No Connection'));
      }

      final newCompanies = <CompanyEntity>[];

      for (final symbol in symbols) {
        final companyModel = await _remoteDataSource.getCompanyProfile(symbol);
        newCompanies.add(companyModel.toEntity);
      }

      return Right(newCompanies);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
