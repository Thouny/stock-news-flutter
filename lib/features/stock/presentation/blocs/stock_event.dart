part of 'stock_bloc.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object?> get props => [];
}

class LoadHistoricalStockEvent extends StockEvent {
  final CompanyEntity company;
  final DateTime from;
  final DateTime to;

  const LoadHistoricalStockEvent({
    required this.company,
    required this.from,
    required this.to,
  });

  @override
  List<Object?> get props => [company, from, to];
}
