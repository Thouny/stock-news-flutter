import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/stock_bloc.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/stock_detail_bottom_sheet.dart';

import '../../../../fixtures/stock_fixtures.dart';

class MockStockBloc extends MockBloc<StockEvent, StockState>
    implements StockBloc {}

void main() {
  late MockStockBloc mockStockBloc;

  const keyPrefix = StockDetailBottomSheetBuilder.keyPrefix;
  const tCompanyEntities = StockFixtures.companiesProfileEntities;
  final tStockEntities = StockFixtures.stockEntities;

  setUp(() {
    mockStockBloc = MockStockBloc();
  });

  tearDown(() {
    mockStockBloc.close();
  });

  group('LoadedStockState', () {
    testWidgets('should render a [StockDetailWidget] widget', (tester) async {
      // arrange
      whenListen(
        mockStockBloc,
        Stream.value(LoadedStockState(
          company: tCompanyEntities.first,
          stocks: tStockEntities,
        )),
        initialState: const InitialStockState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        stockBloc: mockStockBloc,
        company: tCompanyEntities.first,
      ));
      await tester.pumpAndSettle();
      const stockDetailKey = Key('$keyPrefix-StockDetailWidget');
      const errortKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final stockDetail = find.byKey(stockDetailKey);
      final errorCard = find.byKey(errortKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(stockDetail, findsOneWidget);
      expect(errorCard, findsNothing);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('ErrorStockState', () {
    testWidgets('should render [Text] widget', (tester) async {
      // arrange
      whenListen(
        mockStockBloc,
        Stream.value(const ErrorStockState(message: 'Some Error')),
        initialState: const InitialStockState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        stockBloc: mockStockBloc,
        company: tCompanyEntities.first,
      ));
      await tester.pumpAndSettle();
      const stockDetailKey = Key('$keyPrefix-StockDetailWidget');
      const errortKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final stockDetail = find.byKey(stockDetailKey);
      final errorCard = find.byKey(errortKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(stockDetail, findsNothing);
      expect(errorCard, findsOneWidget);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('Other states', () {
    testWidgets('should render [CircularProgressIndicator]', (tester) async {
      // arrange
      whenListen(
        mockStockBloc,
        Stream.value(const InitialStockState()),
        initialState: const InitialStockState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        stockBloc: mockStockBloc,
        company: tCompanyEntities.first,
      ));
      const stockDetailKey = Key('$keyPrefix-StockDetailWidget');
      const errortKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final stockDetail = find.byKey(stockDetailKey);
      final errorCard = find.byKey(errortKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(stockDetail, findsNothing);
      expect(errorCard, findsNothing);
      expect(loadingIndicator, findsOneWidget);
    });
  });
}

class _WidgetWrapper extends StatelessWidget {
  final StockBloc stockBloc;
  final CompanyEntity company;

  const _WidgetWrapper({required this.stockBloc, required this.company});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => stockBloc,
          child: const StockDetailBottomSheetBuilder(),
        ),
      ),
    );
  }
}
