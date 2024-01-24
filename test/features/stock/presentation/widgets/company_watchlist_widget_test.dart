import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/companies_profile_bloc.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/company_watchlist_widget.dart';

import '../../../../fixtures/stock_fixtures.dart';

class MockCompaniesProfileBloc
    extends MockBloc<CompaniesProfileEvent, CompaniesProfileState>
    implements CompaniesProfileBloc {}

void main() {
  late MockCompaniesProfileBloc mockCompaniesProfileBloc;

  const keyPrefix = CompanyWatchListWidget.keyPrefix;

  const tCompanyEntities = StockFixtures.companiesProfileEntities;

  setUp(() {
    mockCompaniesProfileBloc = MockCompaniesProfileBloc();
  });

  tearDown(() {
    mockCompaniesProfileBloc.close();
  });

  group('LoadedCompaniesProfileState', () {
    testWidgets('should render a [Card] widget', (tester) async {
      // arrange
      whenListen(
        mockCompaniesProfileBloc,
        Stream.value(const LoadedCompaniesProfileState(
          companies: tCompanyEntities,
        )),
        initialState: const InitialCompaniesProfileState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        mockCompaniesProfileBloc: mockCompaniesProfileBloc,
        company: tCompanyEntities.first,
      ));
      await tester.pumpAndSettle();
      const titleKey = Key('$keyPrefix-Title');
      const listViewKey = Key('$keyPrefix-ListView');
      const errorKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final title = find.byKey(titleKey);
      final listView = find.byKey(listViewKey);
      final errorCard = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(title, findsOneWidget);
      expect(listView, findsOneWidget);
      expect(errorCard, findsNothing);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('ErrorCompaniesProfileState', () {
    testWidgets('should render [Text] widget', (tester) async {
      // arrange
      whenListen(
        mockCompaniesProfileBloc,
        Stream.value(const ErrorCompaniesProfileState(message: 'Some Error')),
        initialState: const InitialCompaniesProfileState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        mockCompaniesProfileBloc: mockCompaniesProfileBloc,
        company: tCompanyEntities.first,
      ));
      await tester.pumpAndSettle();
      const titleKey = Key('$keyPrefix-Title');
      const listViewKey = Key('$keyPrefix-ListView');
      const errorKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final title = find.byKey(titleKey);
      final listView = find.byKey(listViewKey);
      final errorCard = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(title, findsOneWidget);
      expect(listView, findsNothing);
      expect(errorCard, findsOneWidget);
      expect(loadingIndicator, findsNothing);
    });
  });

  group('Other states', () {
    testWidgets('should render [CircularProgressIndicator]', (tester) async {
      // arrange
      whenListen(
        mockCompaniesProfileBloc,
        Stream.value(const InitialCompaniesProfileState()),
        initialState: const InitialCompaniesProfileState(),
      );
      await tester.pumpWidget(_WidgetWrapper(
        mockCompaniesProfileBloc: mockCompaniesProfileBloc,
        company: tCompanyEntities.first,
      ));
      const titleKey = Key('$keyPrefix-Title');
      const listViewKey = Key('$keyPrefix-ListView');
      const errorKey = Key('$keyPrefix-ErrorCard');
      const loadingIndicatorKey = Key('$keyPrefix-LoadingIndicator');
      // act
      final title = find.byKey(titleKey);
      final listView = find.byKey(listViewKey);
      final errorCard = find.byKey(errorKey);
      final loadingIndicator = find.byKey(loadingIndicatorKey);
      // assert
      expect(title, findsOneWidget);
      expect(listView, findsNothing);
      expect(errorCard, findsNothing);
      expect(loadingIndicator, findsOneWidget);
    });
  });
}

class _WidgetWrapper extends StatelessWidget {
  final CompaniesProfileBloc mockCompaniesProfileBloc;
  final CompanyEntity company;

  const _WidgetWrapper({
    required this.mockCompaniesProfileBloc,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => mockCompaniesProfileBloc,
          child: const CompanyWatchListWidget(),
        ),
      ),
    );
  }
}
