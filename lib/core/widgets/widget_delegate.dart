import 'package:flutter/material.dart';

typedef WidgetDelegateBuilder = Widget Function();

class WidgetDelegate extends StatelessWidget {
  /// Creates a `WidgetDelegate` convenience widget.
  ///
  /// Intended to be a tidier alternative to ternary operators.
  const WidgetDelegate({
    super.key,
    required this.shouldShowPrimary,
    required this.primaryWidget,
    required this.alternateWidget,
  });

  /// Defines the condition as to which widget should be rendered.
  ///
  /// If false, `secondaryWidget` will be created
  final bool shouldShowPrimary;

  /// Sets the primary widget.
  ///
  /// Will be the default rendered widget if `shouldShowPrimary`
  /// is not overriden.
  final WidgetDelegateBuilder primaryWidget;

  /// Sets the alternate widget.
  ///
  /// Will be rendered if `shouldShowPrimary` is `false`.
  final WidgetDelegateBuilder alternateWidget;

  @override
  Widget build(BuildContext context) {
    return shouldShowPrimary ? primaryWidget() : alternateWidget();
  }
}
