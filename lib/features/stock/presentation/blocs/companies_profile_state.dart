part of 'companies_profile_bloc.dart';

abstract class CompaniesProfileState extends Equatable {
  const CompaniesProfileState();

  @override
  List<Object?> get props => [];
}

class InitialCompaniesProfileState extends CompaniesProfileState {
  const InitialCompaniesProfileState();
}

class LoadedCompaniesProfileState extends CompaniesProfileState {
  final List<CompanyEntity> companies;

  const LoadedCompaniesProfileState({required this.companies});

  @override
  List<Object?> get props => [companies];
}

class ErrorCompaniesProfileState extends CompaniesProfileState {
  final String message;

  const ErrorCompaniesProfileState({required this.message});

  @override
  List<Object?> get props => [message];
}
