import 'dart:io';

import 'package:flutter/material.dart';

class ResponsiveUtils extends StatelessWidget {
  const ResponsiveUtils({
    Key? key,
    required this.desktop,
    required this.mobile,
    this.tablet,
  }) : super(key: key);

  final Widget desktop;
  final Widget mobile;
  final Widget? tablet;

  static bool get isIpad {
    return Platform.isIOS &&
        MediaQueryData.fromView(WidgetsBinding.instance.window)
                .size
                .shortestSide >
            600;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1135;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 1100) {
      return desktop;
    } else if (size.width >= 850 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
