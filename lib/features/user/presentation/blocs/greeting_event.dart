part of 'greeting_bloc.dart';

abstract class GreetingEvent extends Equatable {
  const GreetingEvent();

  @override
  List<Object?> get props => [];
}

class LoadGreetingEvent extends GreetingEvent {
  const LoadGreetingEvent();
}
