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

class NetworkFailure extends Failure {
  final String message;
  final int statusCode;

  NetworkFailure({required this.message, required this.statusCode})
      : super([message, statusCode]);

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure();

  @override
  List<Object?> get props => [];
}
