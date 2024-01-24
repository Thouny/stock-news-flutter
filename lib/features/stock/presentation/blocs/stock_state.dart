part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object?> get props => [];
}

class InitialStockState extends StockState {
  const InitialStockState();
}

class LoadedStockState extends StockState {
  final CompanyEntity company;
  final List<StockEntity> stocks;

  const LoadedStockState({required this.company, required this.stocks});

  @override
  List<Object?> get props => [company, stocks];
}

class ErrorStockState extends StockState {
  final String message;

  const ErrorStockState({required this.message});

  @override
  List<Object?> get props => [message];
}
