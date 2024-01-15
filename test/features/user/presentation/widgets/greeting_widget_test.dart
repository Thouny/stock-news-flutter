import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/features/user/presentation/blocs/greeting_bloc.dart';
import 'package:stock_news_flutter/features/user/presentation/widgets/greeting_widget.dart';

class _MockGreetingBloc extends MockBloc<GreetingEvent, GreetingState>
    implements GreetingBloc {}

void main() {
  late _MockGreetingBloc mockGreetingBloc;

  const keyPrefix = GreetingWidget.keyPrefix;
  const tGreeting = 'Good morning';

  setUp(() {
    mockGreetingBloc = _MockGreetingBloc();
    GetIt.I.registerFactory<GreetingBloc>(() => mockGreetingBloc);
  });

  tearDown(() {
    mockGreetingBloc.close();
    GetIt.I.reset();
  });

  testWidgets('should display a greeting message', (tester) async {
    // arrange
    whenListen(
      mockGreetingBloc,
      Stream.value(const LoadedGreetingState(greeting: tGreeting)),
      initialState: const InitialGreetingState(),
    );
    await tester.pumpWidget(_WidgetWrapper(greetingBloc: mockGreetingBloc));
    await tester.pumpAndSettle();
    const greetingTextKey = Key('$keyPrefix-Text');
    // act
    final greetingText = find.byKey(greetingTextKey);
    // assert
    expect(greetingText, findsOneWidget);
  });

  testWidgets('should render a [SizedBox.shrink()]', (tester) async {
    // arrange
    whenListen(
      mockGreetingBloc,
      Stream.value(const InitialGreetingState()),
      initialState: const InitialGreetingState(),
    );
    await tester.pumpWidget(_WidgetWrapper(greetingBloc: mockGreetingBloc));
    await tester.pumpAndSettle();
    // act
    final sizedBox = find.byType(SizedBox);
    // assert
    expect(sizedBox, findsOneWidget);
  });
}

class _WidgetWrapper extends StatelessWidget {
  final GreetingBloc greetingBloc;

  const _WidgetWrapper({required this.greetingBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => greetingBloc,
          child: const GreetingWidget(),
        ),
      ),
    );
  }
}
