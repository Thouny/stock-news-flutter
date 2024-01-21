part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistoricalStockEvent extends StockEvent {
  final String symbol;
  final DateTime from;
  final DateTime to;

  const LoadHistoricalStockEvent({
    required this.symbol,
    required this.from,
    required this.to,
  });

  @override
  List<Object?> get props => [symbol, from, to];
}
