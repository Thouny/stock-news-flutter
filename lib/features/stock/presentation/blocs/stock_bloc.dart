import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_historical_stock.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GetHistoricalStockUsecase _getHistoricalStockUsecase;

  StockBloc({required GetHistoricalStockUsecase getHistoricalStockUsecase})
      : _getHistoricalStockUsecase = getHistoricalStockUsecase,
        super(const InitialStockState()) {
    on<LoadHistoricalStockEvent>(_onLoadHistoricalStock);
  }

  FutureOr<void> _onLoadHistoricalStock(
    LoadHistoricalStockEvent event,
    Emitter<StockState> emit,
  ) async {
    emit(const LoadingStockState());

    final params = GetHistoricalStockParams(
      symbol: event.company.symbol,
      from: event.from,
      to: event.to,
    );
    final stockEither = await _getHistoricalStockUsecase(params);
    stockEither.fold(
      (failure) {
        emit(ErrorStockState(message: failure.message));
      },
      (stocks) {
        emit(LoadedStockState(company: event.company, stocks: stocks));
      },
    );
  }
}
