import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/consts/error_card_consts.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';
import 'package:stock_news_flutter/core/theme/error_card_style.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/core/widgets/widget_delegate.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.message,
    this.shouldRenderCard = true,
  });

  final String? message;
  final bool shouldRenderCard;

  static const keyPrefix = 'ErrorCardWidget';

  @override
  Widget build(BuildContext context) {
    final errorMsg = message ?? ErrorCardConsts.defaultErrorMessage;

    return Theme(
      data: SNErrorCardStyle.roundErrorCard,
      child: WidgetDelegate(
        shouldShowPrimary: shouldRenderCard,
        primaryWidget: () {
          return Card(
            key: const Key('$keyPrefix-Card'),
            child: Padding(
              padding: const EdgeInsets.all(PaddingValues.xSmall),
              child: _Content(
                key: const Key('$keyPrefix-Content'),
                message: errorMsg,
              ),
            ),
          );
        },
        alternateWidget: () {
          return _Content(
            key: const Key('$keyPrefix-Content'),
            message: errorMsg,
          );
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: SNColors.red),
          const SizedBox(height: PaddingValues.xSmall),
          Text(
            key: const Key('${ErrorCard.keyPrefix}-ErrorMessage'),
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
