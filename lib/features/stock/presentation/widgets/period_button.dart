import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';

class PeriodButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback onPressed;

  const PeriodButton({
    Key? key,
    required this.isSelected,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor =
        isSelected ? SNColors.blue : SNColors.lightBlue.withOpacity(0.2);
    final textColor = isSelected ? SNColors.white : Colors.black;
    final textTheme = Theme.of(context).textTheme.bodySmall;

    return Container(
      width: 40,
      height: 36,
      decoration: BoxDecoration(
        color: buttonColor,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            label,
            style: textTheme?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
