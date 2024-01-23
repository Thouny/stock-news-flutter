import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/usecases/get_companies_profile.dart';

part 'companies_profile_event.dart';
part 'companies_profile_state.dart';

class CompaniesProfileBloc
    extends Bloc<CompaniesProfilesEvent, CompaniesProfileState> {
  final GetCompaniesProfileUsecase _getCompaniesProfileUsecase;

  CompaniesProfileBloc(
      {required GetCompaniesProfileUsecase getCompaniesProfileUsecase})
      : _getCompaniesProfileUsecase = getCompaniesProfileUsecase,
        super(const InitialCompaniesProfileState()) {
    on<LoadCompaniesProfileEvent>(_onLoadStockWatchlist);
  }

  FutureOr<void> _onLoadStockWatchlist(
    LoadCompaniesProfileEvent event,
    Emitter<CompaniesProfileState> emit,
  ) async {
    final params = GetCompaniesProfileParams(symbols: event.symbols);

    final companiesEither = await _getCompaniesProfileUsecase(params);
    companiesEither.fold(
      (failure) => emit(ErrorCompaniesProfileState(message: failure.message)),
      (companies) => emit(LoadedCompaniesProfileState(companies: companies)),
    );
  }
}
