import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';

/// M3 bottom bar: 80dp, three gates, stadium primaryContainer indicator.
class NesNavigationBar extends StatelessWidget {
  const NesNavigationBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  // Gate order: log, review, swaps — filled icon when selected.
  static const List<({IconData active, IconData inactive, String labelKey})>
  _tabs = <({IconData active, IconData inactive, String labelKey})>[
    (
      active: Icons.edit_note,
      inactive: Icons.edit_note_outlined,
      labelKey: LangKeys.tabLog,
    ),
    (
      active: Icons.bar_chart,
      inactive: Icons.bar_chart_outlined,
      labelKey: LangKeys.tabReview,
    ),
    (
      active: Icons.swap_horiz,
      inactive: Icons.swap_horiz_outlined,
      labelKey: LangKeys.tabSwaps,
    ),
  ];

  // tabSemantics placeholders {tab} and {index} are replaced manually.
  String _tabSemantics(BuildContext context, String tabLabel, int index) {
    return context
        .translate(LangKeys.tabSemantics)
        .replaceAll('{tab}', tabLabel)
        .replaceAll('{index}', '$index');
  }

  NavigationDestination _destination(BuildContext context, int index) {
    final String label = context.translate(_tabs[index].labelKey);
    return NavigationDestination(
      icon: Icon(_tabs[index].inactive),
      selectedIcon: Icon(_tabs[index].active),
      label: label,
      tooltip: _tabSemantics(context, label, index + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: scheme.primaryContainer,
        indicatorShape: const StadiumBorder(),
        iconTheme: WidgetStateProperty.resolveWith(
          (Set<WidgetState> states) => states.contains(WidgetState.selected)
              ? IconThemeData(color: scheme.primary)
              : IconThemeData(color: scheme.onSurfaceVariant),
        ),
      ),
      child: NavigationBar(
        height: 80.h,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: <Widget>[
          for (int i = 0; i < _tabs.length; i++) _destination(context, i),
        ],
      ),
    );
  }
}
