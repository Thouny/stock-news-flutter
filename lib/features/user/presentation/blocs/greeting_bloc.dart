import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/user/domain/usecases/get_greeting_usecase.dart';

part 'greeting_event.dart';
part 'greeting_state.dart';

class GreetingBloc extends Bloc<GreetingEvent, GreetingState> {
  final GetGreetingUsecase _getGreetingUsecase;

  GreetingBloc({required GetGreetingUsecase getGreetingUsecase})
      : _getGreetingUsecase = getGreetingUsecase,
        super(const InitialGreetingState()) {
    on<LoadGreetingEvent>(_onLoadGreeting);
  }

  FutureOr<void> _onLoadGreeting(
    LoadGreetingEvent event,
    Emitter<GreetingState> emit,
  ) async {
    final greeting = await _getGreetingUsecase(const NoParams());
    emit(LoadedGreetingState(greeting: greeting));
  }
}
