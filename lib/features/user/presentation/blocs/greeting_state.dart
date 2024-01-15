part of 'greeting_bloc.dart';

abstract class GreetingState extends Equatable {
  const GreetingState();

  @override
  List<Object?> get props => [];
}

class InitialGreetingState extends GreetingState {
  const InitialGreetingState();
}

class LoadedGreetingState extends GreetingState {
  final String greeting;

  const LoadedGreetingState({required this.greeting});

  @override
  List<Object> get props => [greeting];
}
