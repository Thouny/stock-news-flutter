import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String name;
  final String symbol;

  const CompanyEntity({
    required this.name,
    required this.symbol,
  });

  @override
  List<Object?> get props => [name, symbol];
}
