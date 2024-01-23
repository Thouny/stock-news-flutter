// Mocks generated by Mockito 5.4.4 from annotations
// in stock_news_flutter/test/features/stock/domain/usecases/get_historical_stock_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:stock_news_flutter/core/error/failures.dart' as _i5;
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart'
    as _i7;
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart'
    as _i6;
import 'package:stock_news_flutter/features/stock/domain/repositories/stock_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [StockRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockStockRepository extends _i1.Mock implements _i3.StockRepository {
  MockStockRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.StockEntity>>> getHistoricalStock(
    String? symbol,
    DateTime? from,
    DateTime? to,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHistoricalStock,
          [
            symbol,
            from,
            to,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.StockEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.StockEntity>>(
          this,
          Invocation.method(
            #getHistoricalStock,
            [
              symbol,
              from,
              to,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.StockEntity>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.CompanyEntity>>>
      getCompaniesProfile(List<String>? symbols) => (super.noSuchMethod(
            Invocation.method(
              #getCompaniesProfile,
              [symbols],
            ),
            returnValue: _i4
                .Future<_i2.Either<_i5.Failure, List<_i7.CompanyEntity>>>.value(
                _FakeEither_0<_i5.Failure, List<_i7.CompanyEntity>>(
              this,
              Invocation.method(
                #getCompaniesProfile,
                [symbols],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i7.CompanyEntity>>>);
}
