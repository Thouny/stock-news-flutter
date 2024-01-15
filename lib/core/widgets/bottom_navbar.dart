import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stock_news_flutter/core/enums/bottom_navbar_item_type.dart';
import 'package:stock_news_flutter/core/theme/bottom_navbar_style.dart';

class BottomNavbar extends StatefulWidget {
  final int selectedIndex;
  final int itemCount;

  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.itemCount,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  double get _indicatorWidth {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / widget.itemCount;
  }

  @override
  Widget build(BuildContext context) {
    const homeItem = BottomNavbarItemType.home;
    const trackerItem = BottomNavbarItemType.tracker;
    const settingsItem = BottomNavbarItemType.settings;

    return Container(
      decoration: const BoxDecoration(
        boxShadow: BottomNavbarStyle.boxShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: BottomNavbarStyle.indicatorHeight,
                color: BottomNavbarStyle.unselectedIndicatorColor,
              ),
              AnimatedPositioned(
                duration: const Duration(
                  milliseconds: BottomNavbarStyle.animationDuration,
                ),
                curve: Curves.easeInOut,
                left: _selectedIndex * _indicatorWidth,
                child: Container(
                  height: BottomNavbarStyle.indicatorHeight,
                  width: _indicatorWidth,
                  color: BottomNavbarStyle.selectedIndicatorColor,
                ),
              ),
            ],
          ),
          BottomAppBar(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: BottomNavbarItem(
                      itemType: homeItem,
                      isSelected: _selectedIndex == homeItem.tabIndex,
                      onPressed: () {
                        TabPage.of(context).index = homeItem.tabIndex;
                        setState(() => _selectedIndex = homeItem.tabIndex);
                      },
                    ),
                  ),
                  Expanded(
                    child: BottomNavbarItem(
                      itemType: trackerItem,
                      isSelected: _selectedIndex == trackerItem.tabIndex,
                      onPressed: () {
                        TabPage.of(context).index = trackerItem.tabIndex;
                        setState(() => _selectedIndex = trackerItem.tabIndex);
                      },
                    ),
                  ),
                  Expanded(
                    child: BottomNavbarItem(
                      itemType: settingsItem,
                      isSelected: _selectedIndex == settingsItem.tabIndex,
                      onPressed: () {
                        TabPage.of(context).index = settingsItem.tabIndex;
                        setState(() => _selectedIndex = settingsItem.tabIndex);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavbarItem extends StatelessWidget {
  const BottomNavbarItem({
    super.key,
    required this.itemType,
    required this.onPressed,
    this.isSelected = false,
  });

  final BottomNavbarItemType itemType;
  final bool isSelected;
  final Function() onPressed;

  Color? get _indicatorColor {
    return isSelected ? BottomNavbarStyle.iconSelectedIndicatorColor : null;
  }

  Color? _iconColor(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;
    final selectedColor = theme.selectedIconTheme?.color;
    final unselectedColor = theme.unselectedIconTheme?.color;
    return isSelected ? selectedColor : unselectedColor;
  }

  TextStyle? _textStyle(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;
    return isSelected ? theme.selectedLabelStyle : theme.unselectedLabelStyle;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _indicatorColor,
            ),
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: onPressed,
              icon: Icon(itemType.icon),
              iconSize: BottomNavbarStyle.iconSize,
              color: _iconColor(context),
            ),
          ),
          Text(itemType.label, style: _textStyle(context)),
        ],
      ),
    );
  }
}
