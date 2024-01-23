import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/domain/usecases/get_top_headlines_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopHeadlinesUsecase _getTopHeadlinesUsecase;

  NewsBloc({required GetTopHeadlinesUsecase getTopHeadlinesUsecase})
      : _getTopHeadlinesUsecase = getTopHeadlinesUsecase,
        super(const InitialNewsState()) {
    on<LoadTopHeadlinesNewsEvent>(_onLoadTopHeadlinesNews);
  }

  FutureOr<void> _onLoadTopHeadlinesNews(
    LoadTopHeadlinesNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    final newsEither = await _getTopHeadlinesUsecase(const NoParams());
    newsEither.fold(
      (failure) {
        emit(ErrorNewsState(message: failure.message));
      },
      (news) => emit(LoadedNewsState(news: news)),
    );
  }
}
