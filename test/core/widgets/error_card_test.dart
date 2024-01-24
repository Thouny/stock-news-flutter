import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_news_flutter/core/consts/error_card_consts.dart';
import 'package:stock_news_flutter/core/widgets/error_card.dart';

void main() {
  const keyPrefix = ErrorCard.keyPrefix;
  const tMessage = 'This is a dynamic error message';
  const tDefaultMessage = ErrorCardConsts.defaultErrorMessage;

  testWidgets(
    'verify Text widget is rendering dynamic message',
    (WidgetTester tester) async {
      //arrange
      await tester.pumpWidget(const _WidgetWrapper(message: tMessage));
      await tester.pumpAndSettle();
      //act
      final finder = find.byKey(const Key('$keyPrefix-ErrorMessage'));
      final text = finder.evaluate().single.widget as Text;
      //assert
      expect(text.data, tMessage);
    },
  );

  testWidgets('verify Text widget is rendering default message',
      (WidgetTester tester) async {
    //arrange
    await tester.pumpWidget(const _WidgetWrapper(message: null));
    await tester.pumpAndSettle();
    //act
    final finder = find.byKey(const Key('$keyPrefix-ErrorMessage'));
    final text = finder.evaluate().single.widget as Text;
    //assert
    expect(text.data, tDefaultMessage);
  });

  testWidgets('verify [Card] widget is rendered', (WidgetTester tester) async {
    //arrange
    await tester.pumpWidget(const _WidgetWrapper(message: tMessage));
    await tester.pumpAndSettle();
    //act
    final card = find.byKey(const Key('$keyPrefix-Card'));
    //assert
    expect(card, findsOneWidget);
  });
}

class _WidgetWrapper extends StatelessWidget {
  const _WidgetWrapper({required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ErrorCard(message: message),
      ),
    );
  }
}
