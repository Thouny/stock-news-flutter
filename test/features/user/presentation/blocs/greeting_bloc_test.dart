import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/features/user/domain/usecases/get_greeting_usecase.dart';
import 'package:stock_news_flutter/features/user/presentation/blocs/greeting_bloc.dart';

import 'greeting_bloc_test.mocks.dart';

@GenerateMocks([GetGreetingUsecase])
void main() {
  late GreetingBloc bloc;
  late MockGetGreetingUsecase mockGetGreetingUsecase;

  const tGreetingMessage = 'Good morning';

  setUp(() {
    mockGetGreetingUsecase = MockGetGreetingUsecase();
    bloc = GreetingBloc(getGreetingUsecase: mockGetGreetingUsecase);
  });

  tearDown(() {
    reset(mockGetGreetingUsecase);
  });

  group('LoadGreetingEvent', () {
    blocTest<GreetingBloc, GreetingState>(
      'should emit [LoadedGreetingState] when the usecase returns a value',
      setUp: () {
        when(mockGetGreetingUsecase.call(any))
            .thenAnswer((_) async => const Right(tGreetingMessage));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadGreetingEvent()),
      expect: () => [const LoadedGreetingState(greeting: tGreetingMessage)],
    );

    blocTest<GreetingBloc, GreetingState>(
      'should emit [ErrorGreetingState] when the usecase returns a failure',
      setUp: () {
        when(mockGetGreetingUsecase.call(any)).thenAnswer(
            (_) async => const Left(ClockFailure(message: 'Clock Failure')));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const LoadGreetingEvent()),
      expect: () => [const ErrorGreetingState(message: 'Clock Failure')],
    );
  });
}
