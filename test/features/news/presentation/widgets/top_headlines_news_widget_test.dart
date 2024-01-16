import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'package:stock_news_flutter/features/news/presentation/bloc/news_bloc.dart';
import 'package:stock_news_flutter/features/news/presentation/widgets/top_headlines_news_widget.dart';

import 'top_headlines_news_widget_test.mocks.dart';

class MockNewsBloc extends MockBloc<NewsEvent, NewsState> implements NewsBloc {}

@GenerateMocks([LinkHandler])
void main() {
  late MockNewsBloc mockNewsBloc;
  late MockLinkHandler mockLinkHandler;

  // const tNewsEntity = NewsEntity(
  //   title: 'title',
  //   description: 'description',
  //   url: 'url',
  //   urlToImage: 'urlToImage',
  //   publishedAt: '',
  //   content: 'content',
  //   source: Source(id: 'id', name: 'name'),
  //   author: '',
  // );

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

  // group('LoadedNewsState', () {
  //   testWidgets('should render a [ListView] widget', (tester) async {
  //     // arrange
  //     whenListen(
  //       mockNewsBloc,
  //       Stream.value(const LoadedNewsState(news: [tNewsEntity])),
  //       initialState: const InitialNewsState(),
  //     );

  //     await mockNetworkImagesFor(() => tester.pumpWidget(_WidgetWrapper(
  //           newsBloc: mockNewsBloc,
  //           linkHandler: mockLinkHandler,
  //         )));

  //     await tester.pumpAndSettle();
  //     const listViewKey = Key('$keyPrefix-ListView');
  //     // act
  //     final listView = find.byKey(listViewKey);
  //     // assert
  //     expect(listView, findsOneWidget);
  //   });
  // });

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
      const textKey = Key('$keyPrefix-ErrorText');
      // act
      final text = find.byKey(textKey);
      // assert
      expect(text, findsOneWidget);
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
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
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
