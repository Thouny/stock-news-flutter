import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String name;
  final String symbol;
  final String exchange;
  final String currency;

  const CompanyEntity({
    required this.name,
    required this.symbol,
    required this.exchange,
    required this.currency,
  });

  @override
  List<Object?> get props => [name, symbol, exchange, currency];
}
