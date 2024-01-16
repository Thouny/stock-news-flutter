import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

class ClockFailure extends Failure {
  const ClockFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [];
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure();

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure({required this.message}) : super([message]);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message}) : super([message]);

  @override
  List<Object?> get props => [message];
}
