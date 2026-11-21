import 'package:flutter/material.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/widgets/nes_navigation_bar.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/log/ui/log_screen.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';
import 'package:nesba_ai/features/review/ui/review_screen.dart';
import 'package:nesba_ai/features/swaps/ui/swaps_screen.dart';

/// Home shell — the three gates ride an IndexedStack behind the nav bar,
/// each keeping its state alive across tab switches; every gate arrival
/// refreshes today's data from the shared source so no gate goes stale.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _goTo(int index) {
    setState(() => _currentIndex = index);
    // Spec §3.1: today's data is one truth — the gate that just surfaced
    // re-reads it (a save on سجّل reaches راجع, a delete reaches back).
    if (index == 0) sl<LogCubit>().loadTodayMeals();
    if (index == 1) sl<ReviewCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          LogScreen(onGoToReview: () => _goTo(1)),
          ReviewScreen(onGoToLog: () => _goTo(0)),
          SwapsScreen(onGoToLog: () => _goTo(0)),
        ],
      ),
      bottomNavigationBar: NesNavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _goTo,
      ),
    );
  }
}
