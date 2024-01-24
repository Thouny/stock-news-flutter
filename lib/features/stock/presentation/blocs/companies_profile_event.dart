part of 'companies_profile_bloc.dart';

abstract class CompaniesProfileEvent extends Equatable {
  const CompaniesProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadCompaniesProfileEvent extends CompaniesProfileEvent {
  final List<String> symbols;

  const LoadCompaniesProfileEvent({required this.symbols});

  @override
  List<Object?> get props => [symbols];
}
