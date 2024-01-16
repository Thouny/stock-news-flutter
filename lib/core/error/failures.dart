import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message, [List properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [
        message,
      ];
}

class ClockFailure extends Failure {
  const ClockFailure(super.message);
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
