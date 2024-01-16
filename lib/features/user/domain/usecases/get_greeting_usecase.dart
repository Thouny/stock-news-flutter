import 'package:dartz/dartz.dart';
import 'package:stock_news_flutter/core/error/failures.dart';
import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/core/utils/clock.dart';

class GetGreetingUsecase implements Usecase<String, NoParams> {
  final Clock _clock;

  GetGreetingUsecase({required Clock clock}) : _clock = clock;

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    try {
      final now = _clock.now();
      if (now.hour < 12) {
        return const Right('Good morning ☕️');
      } else if (now.hour >= 12 && now.hour < 18) {
        return const Right('Good afternoon ☀️');
      } else {
        return const Right('Good evening 🌙');
      }
    } catch (_) {
      return const Left(ClockFailure(message: 'Clock Failure'));
    }
  }
}
