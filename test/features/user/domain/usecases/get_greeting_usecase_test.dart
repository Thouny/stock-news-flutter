import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/core/utils/clock.dart';
import 'package:stock_news_flutter/features/user/domain/usecases/get_greeting_usecase.dart';

import 'get_greeting_usecase_test.mocks.dart';

@GenerateMocks([Clock])
void main() {
  late GetGreetingUsecase usecase;
  late MockClock mockClock;

  final morningTime = DateTime(2017, 9, 7, 8, 30);
  final afternoonTime = DateTime(2017, 9, 7, 14, 30);
  final eveningTime = DateTime(2017, 9, 7, 18, 30);
  const tClockFailure = ClockFailure(message: 'Clock Failure');

  setUp(() {
    mockClock = MockClock();
    usecase = GetGreetingUsecase(clock: mockClock);
  });

  tearDown(() {
    reset(mockClock);
  });

  test('should return a ClockFailure when clock throws an exception', () async {
    // arrange
    when(mockClock.now()).thenThrow((_) => tClockFailure);
    // act
    final greeting = await usecase(const NoParams());
    // assert
    expect(greeting, const Left(tClockFailure));
  });

  test('should return Good morning when time is in the morning', () async {
    // arrange
    when(mockClock.now()).thenAnswer((_) => morningTime);
    // act
    final greeting = await usecase(const NoParams());
    // assert
    expect(greeting, const Right('Good morning ☕️'));
  });

  test('should return Good afternoon when time is in the afternoon', () async {
    // arrange
    when(mockClock.now()).thenAnswer((_) => afternoonTime);
    // act
    final greeting = await usecase(const NoParams());
    // assert
    expect(greeting, const Right('Good afternoon ☀️'));
  });

  test('should return Good evening when time is in the evening', () async {
    // arrange
    when(mockClock.now()).thenAnswer((_) => eveningTime);
    // act
    final greeting = await usecase(const NoParams());
    // assert
    expect(greeting, const Right('Good evening 🌙'));
  });
}
