import 'package:flutter/material.dart';
import 'package:stock_news_flutter/core/utils/responsive_utils.dart';
import 'package:stock_news_flutter/core/widgets/side_menu.dart';

class LayoutDelegate extends StatelessWidget {
  final Widget child;

  const LayoutDelegate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ResponsiveUtils.isTablet(context))
          const Expanded(child: SideMenu()),
        Expanded(flex: 4, child: child),
      ],
    );
  }
}
