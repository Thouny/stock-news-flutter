part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class InitialNewsState extends NewsState {
  const InitialNewsState();
}

class LoadingNewsState extends NewsState {
  const LoadingNewsState();
}

class LoadedNewsState extends NewsState {
  final List<NewsEntity> news;

  const LoadedNewsState({required this.news});

  @override
  List<Object> get props => [news];
}

class ErrorNewsState extends NewsState {
  final String message;

  const ErrorNewsState({required this.message});

  @override
  List<Object> get props => [message];
}
