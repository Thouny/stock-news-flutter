import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/presentation/blocs/news_bloc.dart';
import 'package:stock_news_flutter/features/news/presentation/widgets/top_headlines_news_widget.dart';

import 'top_headlines_news_widget_test.mocks.dart';

class MockNewsBloc extends MockBloc<NewsEvent, NewsState> implements NewsBloc {}

@GenerateMocks([LinkHandler])
void main() {
  late MockNewsBloc mockNewsBloc;
  late MockLinkHandler mockLinkHandler;

  const tNewsEntity = NewsEntity(
    title: 'title',
    description: 'description',
    url: 'url',
    urlToImage: '',
    publishedAt: '',
    content: 'content',
    source: Source(id: 'id', name: 'name'),
    author: '',
  );

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
        Stream.value(const LoadedNewsState(news: [tNewsEntity])),
        initialState: const InitialNewsState(),
      );

      await tester.pumpWidget(_WidgetWrapper(
        newsBloc: mockNewsBloc,
        linkHandler: mockLinkHandler,
      ));

      await tester.pumpAndSettle();
      const gridViewKey = Key('$keyPrefix-GridView');
      const errorKey = Key('$keyPrefix-ErrorText');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final gridView = find.byKey(gridViewKey);
      final errorText = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(gridView, findsOneWidget);
      expect(errorText, findsNothing);
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
      const errorKey = Key('$keyPrefix-ErrorText');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final gridView = find.byKey(gridViewKey);
      final errorText = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(gridView, findsNothing);
      expect(errorText, findsOneWidget);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('Other states', () {
    testWidgets('should render [CircularProgressIndicator]', (tester) async {
      // arrange
      whenListen(
        mockNewsBloc,
        Stream.value(const LoadingNewsState()),
        initialState: const InitialNewsState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        newsBloc: mockNewsBloc,
        linkHandler: mockLinkHandler,
      ));
      const gridViewKey = Key('$keyPrefix-GridView');
      const errorKey = Key('$keyPrefix-ErrorText');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final gridView = find.byKey(gridViewKey);
      final errorText = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(gridView, findsNothing);
      expect(errorText, findsNothing);
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
