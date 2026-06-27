import 'package:flutter/foundation.dart';

/// Controls app-wide light/dark theme.
class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  /// Toggles between light and dark theme.
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
