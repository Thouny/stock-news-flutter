import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/stock_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/stock_bloc.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/stock_detail_bottom_sheet.dart';

class MockStockBloc extends MockBloc<StockEvent, StockState>
    implements StockBloc {}

void main() {
  late MockStockBloc mockStockBloc;

  const keyPrefix = StockDetailBottomSheetBuilder.keyPrefix;

  final tStockEntities = [
    StockEntity(
      date: DateTime(2024, 01, 18),
      open: 186.09,
      high: 189.14,
      low: 185.83,
      close: 188.63,
      adjClose: 188.63,
      volume: 77500694,
      unadjustedVolume: 77082288,
      change: 2.54,
      changePercent: 1.36,
      vwap: 187.93,
      label: "January 18, 24",
      changeOverTime: 0.0136,
    ),
    StockEntity(
      date: DateTime(2024, 01, 19),
      open: 186.09,
      high: 189.14,
      low: 185.83,
      close: 188.63,
      adjClose: 188.63,
      volume: 77500694,
      unadjustedVolume: 77082288,
      change: 2.54,
      changePercent: 1.36,
      vwap: 187.93,
      label: "January 19, 24",
      changeOverTime: 0.0136,
    )
  ];

  setUp(() {
    mockStockBloc = MockStockBloc();
    GetIt.I.registerFactory<StockBloc>(() => mockStockBloc);
  });

  tearDown(() {
    mockStockBloc.close();
    GetIt.I.reset();
  });

  group('LoadedStockState', () {
    testWidgets('should render a [StockDetailWidget] widget', (tester) async {
      // arrange
      whenListen(
        mockStockBloc,
        Stream.value(LoadedStockState(
            company: StockConsts.companyWatchlist.first,
            stocks: tStockEntities)),
        initialState: const InitialStockState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        stockBloc: mockStockBloc,
        company: StockConsts.companyWatchlist.first,
      ));
      await tester.pumpAndSettle();
      const stockDetailKey = Key('$keyPrefix-StockDetailWidget');
      const errortKey = Key('$keyPrefix-ErrorText');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final stockDetail = find.byKey(stockDetailKey);
      final errorText = find.byKey(errortKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(stockDetail, findsOneWidget);
      expect(errorText, findsNothing);
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
        company: StockConsts.companyWatchlist.first,
      ));
      await tester.pumpAndSettle();
      const stockDetailKey = Key('$keyPrefix-StockDetailWidget');
      const errortKey = Key('$keyPrefix-ErrorText');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final stockDetail = find.byKey(stockDetailKey);
      final errorText = find.byKey(errortKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(stockDetail, findsNothing);
      expect(errorText, findsOneWidget);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('Other states', () {
    testWidgets('should render [CircularProgressIndicator]', (tester) async {
      // arrange
      whenListen(
        mockStockBloc,
        Stream.value(const LoadingStockState()),
        initialState: const InitialStockState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        stockBloc: mockStockBloc,
        company: StockConsts.companyWatchlist.first,
      ));
      const stockDetailKey = Key('$keyPrefix-StockDetailWidget');
      const errortKey = Key('$keyPrefix-ErrorText');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final stockDetail = find.byKey(stockDetailKey);
      final errorText = find.byKey(errortKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(stockDetail, findsNothing);
      expect(errorText, findsNothing);
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
