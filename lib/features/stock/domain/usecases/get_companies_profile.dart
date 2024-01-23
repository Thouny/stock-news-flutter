import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart';

class GetCompaniesProfileUsecase
    implements Usecase<List<CompanyEntity>, GetCompaniesProfileParams> {
  final StockRepository repository;

  GetCompaniesProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, List<CompanyEntity>>> call(
    GetCompaniesProfileParams params,
  ) async {
    return repository.getCompaniesProfile(params.symbols);
  }
}

class GetCompaniesProfileParams extends Equatable {
  final List<String> symbols;

  const GetCompaniesProfileParams({required this.symbols});

  @override
  List<Object?> get props => [symbols];
}
