import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stock_news_flutter/core/utils/responsive_utils.dart';
import 'package:stock_news_flutter/core/widgets/bottom_navbar.dart';

class RootPageTabScaffold extends StatefulWidget {
  const RootPageTabScaffold({Key? key}) : super(key: key);

  @override
  State<RootPageTabScaffold> createState() => _RootPageTabScaffoldState();
}

class _RootPageTabScaffoldState extends State<RootPageTabScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabState = TabPage.of(context);
    final currentPath = Routemaster.of(context).currentRoute.fullPath;
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      bottomNavigationBar: !isTablet
          ? BottomNavbar(
              currentIndex: tabState.index,
              onTap: (index) {
                setState(() => tabState.index = index);
              },
            )
          : null,
      body: HeroControllerScope(
        controller: MaterialApp.createMaterialHeroController(),
        child: PageStackNavigator(
          key: ValueKey(currentPath),
          stack: tabState.stacks[tabState.index],
        ),
      ),
    );
  }
}
