import 'package:stock_news_flutter/core/usercase/usecase.dart';
import 'package:stock_news_flutter/core/utils/clock.dart';

class GetGreetingUsecase implements Usecase<String, NoParams> {
  final Clock _clock;

  GetGreetingUsecase({required Clock clock}) : _clock = clock;

  @override
  Future<String> call(NoParams params) async {
    final now = _clock.now();
    if (now.hour < 12) {
      return 'Good morning ☕️';
    } else if (now.hour >= 12 && now.hour < 18) {
      return 'Good afternoon ☀️';
    } else {
      return 'Good evening 🌙';
    }
  }
}
