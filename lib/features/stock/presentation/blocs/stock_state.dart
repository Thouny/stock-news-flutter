part of 'stock_bloc.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object?> get props => [];
}

class InitialStockState extends StockState {
  const InitialStockState();
}

class LoadingStockState extends StockState {
  const LoadingStockState();
}

class LoadedStockState extends StockState {
  final List<StockEntity> stocks;

  const LoadedStockState({required this.stocks});

  @override
  List<Object?> get props => [stocks];
}

class ErrorStockState extends StockState {
  final String message;

  const ErrorStockState({required this.message});

  @override
  List<Object?> get props => [message];
}
