import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stock_news_flutter/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
