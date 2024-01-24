import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'package:stock_news_flutter/features/news/presentation/blocs/news_bloc.dart';
import 'package:stock_news_flutter/features/news/presentation/widgets/top_headlines_news_widget.dart';

import '../../../../fixtures/news_fixtures.dart';
import 'top_headlines_news_widget_test.mocks.dart';

class MockNewsBloc extends MockBloc<NewsEvent, NewsState> implements NewsBloc {}

@GenerateMocks([LinkHandler])
void main() {
  late MockNewsBloc mockNewsBloc;
  late MockLinkHandler mockLinkHandler;

  const tNewsEntities = NewsFixtures.newsEntities;

  const keyPrefix = TopHealinesNewsWidget.keyPrefix;

  setUp(() {
    mockNewsBloc = MockNewsBloc();
    mockLinkHandler = MockLinkHandler();
    GetIt.I.registerFactory<NewsBloc>(() => mockNewsBloc);
  });

  tearDown(() {
    mockNewsBloc.close();
    reset(mockLinkHandler);
    GetIt.I.reset();
  });

  group('LoadedNewsState', () {
    testWidgets('should render a [GridView] widget', (tester) async {
      // arrange
      whenListen(
        mockNewsBloc,
        Stream.value(const LoadedNewsState(news: tNewsEntities)),
        initialState: const InitialNewsState(),
      );

      await tester.pumpWidget(_WidgetWrapper(
        newsBloc: mockNewsBloc,
        linkHandler: mockLinkHandler,
      ));

      await tester.pumpAndSettle();
      const gridViewKey = Key('$keyPrefix-GridView');
      const errorKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final gridView = find.byKey(gridViewKey);
      final errorCard = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(gridView, findsOneWidget);
      expect(errorCard, findsNothing);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('ErrorNewsState', () {
    testWidgets('should render [Text] widget', (tester) async {
      // arrange
      whenListen(
        mockNewsBloc,
        Stream.value(const ErrorNewsState(message: 'Some Error')),
        initialState: const InitialNewsState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        newsBloc: mockNewsBloc,
        linkHandler: mockLinkHandler,
      ));
      await tester.pumpAndSettle();
      const gridViewKey = Key('$keyPrefix-GridView');
      const errorKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final gridView = find.byKey(gridViewKey);
      final errorCard = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(gridView, findsNothing);
      expect(errorCard, findsOneWidget);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('Other states', () {
    testWidgets('should render [CircularProgressIndicator]', (tester) async {
      // arrange
      whenListen(
        mockNewsBloc,
        Stream.value(const InitialNewsState()),
        initialState: const InitialNewsState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        newsBloc: mockNewsBloc,
        linkHandler: mockLinkHandler,
      ));
      const gridViewKey = Key('$keyPrefix-GridView');
      const errorKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final gridView = find.byKey(gridViewKey);
      final errorCard = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(gridView, findsNothing);
      expect(errorCard, findsNothing);
      expect(loadingIndicator, findsOneWidget);
    });
  });
}

class _WidgetWrapper extends StatelessWidget {
  final NewsBloc newsBloc;
  final LinkHandler linkHandler;

  const _WidgetWrapper({required this.newsBloc, required this.linkHandler});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => newsBloc,
          child: TopHealinesNewsWidget(linkHandler: linkHandler),
        ),
      ),
    );
  }
}
