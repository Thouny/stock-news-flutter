part of 'companies_profile_bloc.dart';

abstract class CompaniesProfilesEvent extends Equatable {
  const CompaniesProfilesEvent();

  @override
  List<Object?> get props => [];
}

class LoadCompaniesProfileEvent extends CompaniesProfilesEvent {
  final List<String> symbols;

  const LoadCompaniesProfileEvent({required this.symbols});

  @override
  List<Object?> get props => [symbols];
}
