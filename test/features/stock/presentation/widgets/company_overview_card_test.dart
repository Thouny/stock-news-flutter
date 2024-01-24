import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:stock_news_flutter/core/consts/stock_consts.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/company_overview_card.dart';

void main() {
  const keyPrefix = CompanyOverviewCard.keyPrefix;

  final tCompanyEntity = StockConsts.companyWatchlist.first;

  testWidgets('should render expected widgets', (tester) async {
    // arrange
    await tester.pumpWidget(_WidgetWrapper(company: tCompanyEntity));
    await tester.pumpAndSettle();
    const symbolKey = Key('$keyPrefix-Symbol');
    const companyNameKey = Key('$keyPrefix-CompanyName');
    const priceKey = Key('$keyPrefix-Price');
    const changePercentKey = Key('$keyPrefix-ChangePercent');
    // act
    final symbolText = find.byKey(symbolKey);
    final companyNameText = find.byKey(companyNameKey);
    final priceText = find.byKey(priceKey);
    final changePercentText = find.byKey(changePercentKey);
    // assert
    expect(symbolText, findsOneWidget);
    expect(companyNameText, findsOneWidget);
    expect(priceText, findsOneWidget);
    expect(changePercentText, findsOneWidget);
  });
}

class _WidgetWrapper extends StatelessWidget {
  final CompanyEntity company;

  const _WidgetWrapper({required this.company});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CompanyOverviewCard(company: company),
      ),
    );
  }
}
