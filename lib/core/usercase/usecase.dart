import 'package:equatable/equatable.dart';

abstract class Usecase<Type, Params> {
  Future<Type?> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}