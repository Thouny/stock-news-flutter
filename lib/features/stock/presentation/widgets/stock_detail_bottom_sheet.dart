import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/core/widgets/error_card.dart';
import 'package:stock_news_flutter/di/container.dart';
import 'package:stock_news_flutter/features/stock/domain/entities/company_entity.dart';
import 'package:stock_news_flutter/features/stock/presentation/blocs/stock_bloc.dart';
import 'package:stock_news_flutter/features/stock/presentation/widgets/stock_detail_widget.dart';

class StockDetailBottomSheetWrapper extends StatelessWidget {
  final CompanyEntity company;

  const StockDetailBottomSheetWrapper({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return BlocProvider<StockBloc>(
      create: (context) {
        final bloc = serviceLocator<StockBloc>();
        bloc.add(LoadHistoricalStockEvent(
          company: company,
          from: today.subtract(const Duration(days: 1825)),
          to: today,
        ));
        return bloc;
      },
      child: const StockDetailBottomSheetBuilder(),
    );
  }
}

class StockDetailBottomSheetBuilder extends StatelessWidget {
  const StockDetailBottomSheetBuilder({super.key});

  static const keyPrefix = 'StockDetailBottomSheet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(PaddingValues.small),
        child: Column(
          children: [
            BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                if (state is LoadedStockState) {
                  return StockDetailWidget(
                    key: const Key('$keyPrefix-StockDetailWidget'),
                    stocks: state.stocks,
                    company: state.company,
                  );
                } else if (state is ErrorStockState) {
                  return ErrorCard(
                    key: const Key('$keyPrefix-ErrorCard'),
                    message: state.message,
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    key: Key('$keyPrefix-LoadingIndicator'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
