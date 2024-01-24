import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/theme/border_radius.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/companies_profile_bloc.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/stock_detail_bottom_sheet.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/company_overview_card.dart';

class CompanyWatchListWidget extends StatelessWidget {
  static const keyPrefix = 'CompanyWatchListWidget';

  const CompanyWatchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key: const Key('$keyPrefix-Title'),
          "My Stocks Watchlist",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: PaddingValues.small),
        const Expanded(child: _CompanyListView()),
      ],
    );
  }
}

class _CompanyListView extends StatelessWidget {
  const _CompanyListView();

  void showModal(BuildContext context, CompanyEntity company) {
    const radius = Radius.circular(BorderRadiusValues.xLarge);
    const borderRadius = BorderRadius.only(topLeft: radius, topRight: radius);
    const shape = RoundedRectangleBorder(borderRadius: borderRadius);

    showModalBottomSheet<void>(
      shape: shape,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: FractionallySizedBox(
            heightFactor: 0.90,
            child: StockDetailBottomSheetWrapper(company: company),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesProfileBloc, CompaniesProfileState>(
      builder: (context, state) {
        if (state is LoadedCompaniesProfileState) {
          return ListView.builder(
            key: const Key('${CompanyWatchListWidget.keyPrefix}-ListView'),
            itemCount: state.companies.length,
            itemBuilder: (context, index) {
              final company = state.companies[index];
              return CompanyOverviewCard(
                company: company,
                onTap: () => showModal(context, company),
              );
            },
          );
        } else if (state is ErrorCompaniesProfileState) {
          return Center(
            child: Text(
              state.message,
              key: const Key('${CompanyWatchListWidget.keyPrefix}-ErrorText'),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              key: Key('${CompanyWatchListWidget.keyPrefix}-LoadingIndicator'),
            ),
          );
        }
      },
    );
  }
}
