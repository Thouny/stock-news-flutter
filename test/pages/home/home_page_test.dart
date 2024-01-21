import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'package:stock_news_flutter/features/news/presentation/blocs/news_bloc.dart';
import 'package:stock_news_flutter/features/user/presentation/blocs/greeting_bloc.dart';
import 'package:stock_news_flutter/features/user/presentation/widgets/greeting_widget.dart';
import 'package:stock_news_flutter/pages/home/home_page.dart';

import 'home_page_test.mocks.dart';

class _MockGreetingBloc extends MockBloc<GreetingEvent, GreetingState>
    implements GreetingBloc {}

class _MockNewsBloc extends MockBloc<NewsEvent, NewsState>
    implements NewsBloc {}

@GenerateMocks([LinkHandler])
void main() {
  late _MockGreetingBloc mockGreetingBloc;
  late _MockNewsBloc mockNewsBloc;
  late MockLinkHandler mockLinkHandler;

  const keyPrefix = GreetingWidget.keyPrefix;
  const tGreeting = 'Good morning';

  setUp(() {
    mockGreetingBloc = _MockGreetingBloc();
    mockNewsBloc = _MockNewsBloc();
    mockLinkHandler = MockLinkHandler();
    GetIt.I.registerFactory<GreetingBloc>(() => mockGreetingBloc);
    GetIt.I.registerFactory<NewsBloc>(() => mockNewsBloc);
    GetIt.I.registerFactory<LinkHandler>(() => mockLinkHandler);
  });

  tearDown(() {
    mockGreetingBloc.close();
    GetIt.I.reset();
  });

  testWidgets('should render expected widgets', (tester) async {
    // arrange
    whenListen(
      mockGreetingBloc,
      Stream.value(const LoadedGreetingState(greeting: tGreeting)),
      initialState: const InitialGreetingState(),
    );
    whenListen(
      mockNewsBloc,
      Stream.value(const LoadedNewsState(news: [])),
      initialState: const InitialNewsState(),
    );
    await tester.pumpWidget(_WidgetWrapper(
      greetingBloc: mockGreetingBloc,
      newsBloc: mockNewsBloc,
    ));
    await tester.pumpAndSettle();
    const greetingTextKey = Key('$keyPrefix-Text');
    // act
    final greetingText = find.byKey(greetingTextKey);
    // assert
    expect(greetingText, findsOneWidget);
  });
}

class _WidgetWrapper extends StatelessWidget {
  final GreetingBloc greetingBloc;
  final NewsBloc newsBloc;

  const _WidgetWrapper({required this.greetingBloc, required this.newsBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => greetingBloc,
            ),
            BlocProvider(
              create: (context) => newsBloc,
            ),
          ],
          child: const HomeView(),
        ),
      ),
    );
  }
}
