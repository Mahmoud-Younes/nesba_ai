import 'package:flutter/material.dart';
import 'package:nesba_ai/core/widgets/nes_navigation_bar.dart';
import 'package:nesba_ai/features/log/ui/log_screen.dart';
import 'package:nesba_ai/features/review/ui/review_screen.dart';
import 'package:nesba_ai/features/swaps/ui/swaps_screen.dart';

/// Home shell — the three gates ride an IndexedStack behind the nav bar,
/// each keeping its state alive across tab switches.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _goTo(int index) => setState(() => _currentIndex = index);

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
