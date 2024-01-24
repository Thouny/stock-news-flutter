import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:stock_news_flutter/core/widgets/widget_delegate.dart';

import 'widget_delegate_test.mocks.dart';

@GenerateMocks([BuildContext])
void main() {
  final tPrimaryWidget = Container();
  const tAlternateWidget = SizedBox();

  testWidgets('should return [primaryWidget] from build', (tester) async {
    // arrange
    final delegate = WidgetDelegate(
      shouldShowPrimary: true,
      primaryWidget: () => tPrimaryWidget,
      alternateWidget: () => tAlternateWidget,
    );
    // action
    final result = delegate.build(MockBuildContext());
    // assert
    expect(result.runtimeType, Container);
  });

  testWidgets('should return [alternateWidget] from build', (tester) async {
    // arrange
    final delegate = WidgetDelegate(
      shouldShowPrimary: false,
      primaryWidget: () => tPrimaryWidget,
      alternateWidget: () => tAlternateWidget,
    );
    // action
    final result = delegate.build(MockBuildContext());
    // assert
    expect(result.runtimeType, SizedBox);
  });
}
