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
        // We want this side menu only for large screen
        if (ResponsiveUtils.isIpad)
          const Expanded(
            // default flex = 1
            // and it takes 1/6 part of the screen
            child: SideMenu(),
          ),
        Expanded(
          // It takes 5/6 part of the screen
          flex: 4,
          child: child,
        ),
      ],
    );
  }
}
