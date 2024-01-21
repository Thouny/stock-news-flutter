import 'package:flutter_test/flutter_test.dart';
import 'package:stock_news_flutter/core/extension/date_time.dart';

void main() {
  group('toDateString', () {
    test('should return date in string format', () async {
      // arrange
      final tDate = DateTime(2024, 01, 18, 12, 00, 00);
      // act
      final result = tDate.toDateString;
      // assert
      expect(result, '2024-01-18');
    });
  });
}
