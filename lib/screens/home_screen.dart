import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'add_subject_screen.dart';
import 'subject_list_screen.dart';
import 'summary_screen.dart';

/// Root shell with BottomNavigationBar and AppBar theme toggle.
/// Navigation state is managed by Provider — no setState.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _screens = [
    AddSubjectScreen(),
    SubjectListScreen(),
    SummaryScreen(),
  ];

  static const _titles = [
    'Add Subject',
    'Subject List',
    'Summary',
  ];

  static const _icons = [
    Icons.add_circle_outline_rounded,
    Icons.list_alt_rounded,
    Icons.bar_chart_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavProvider(),
      child: Consumer<_NavProvider>(
        builder: (context, nav, _) {
          final themeProvider = context.watch<ThemeProvider>();
          final colorScheme = Theme.of(context).colorScheme;

          return Scaffold(
            appBar: AppBar(
              title: Text(_titles[nav.index]),
              actions: [
                IconButton(
                  key: const Key('theme_toggle_button'),
                  tooltip: themeProvider.isDark
                      ? 'Switch to Light Mode'
                      : 'Switch to Dark Mode',
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) =>
                        RotationTransition(
                          turns: anim,
                          child: FadeTransition(opacity: anim, child: child),
                        ),
                    child: Icon(
                      themeProvider.isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      key: ValueKey(themeProvider.isDark),
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  onPressed: () =>
                      context.read<ThemeProvider>().toggleTheme(),
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(nav.index),
                child: _screens[nav.index],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: nav.index,
              onTap: nav.setIndex,
              items: List.generate(
                3,
                (i) => BottomNavigationBarItem(
                  icon: Icon(_icons[i]),
                  label: _titles[i],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Tiny provider to manage which tab is selected — no setState in screens.
class _NavProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void setIndex(int i) {
    if (_index != i) {
      _index = i;
      notifyListeners();
    }
  }
}
