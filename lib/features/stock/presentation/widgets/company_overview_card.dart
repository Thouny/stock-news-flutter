import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/theme/border_radius.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';

class CompanyOverviewCard extends StatelessWidget {
  final CompanyEntity company;
  final VoidCallback? onTap;

  const CompanyOverviewCard({super.key, required this.company, this.onTap});

  static const keyPrefix = 'CompanyOverviewCard';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(key: const Key('$keyPrefix-Symbol'), company.symbol),
          subtitle: Text(
            key: const Key('$keyPrefix-CompanyName'),
            company.companyName,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                key: const Key('$keyPrefix-Price'),
                company.price.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              _ChangePercentWidget(changePercent: company.changes),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangePercentWidget extends StatelessWidget {
  final double changePercent;

  const _ChangePercentWidget({required this.changePercent});

  String get _changePercentString {
    final changePercentString = changePercent.toStringAsFixed(2);
    if (!changePercent.isNegative) {
      return '+$changePercentString';
    } else {
      return changePercentString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PaddingValues.xxxSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BorderRadiusValues.xSmall),
        color: changePercent.isNegative ? SNColors.red : SNColors.green,
      ),
      child: Text(
        key: const Key('${CompanyOverviewCard.keyPrefix}-ChangePercent'),
        _changePercentString,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
