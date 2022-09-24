
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  // Define your default thememode here
  ThemeMode themeMode = ThemeMode.light;
  SharedPreferences? prefs;
  bool isDark = false;

  ThemeNotifier() {
    _init();
  }

  _init() async {
    // Get the stored theme from shared preferences
    prefs = await SharedPreferences.getInstance();

    int _theme = prefs?.getInt("theme") ?? themeMode.index;
    themeMode = ThemeMode.values[_theme];
    notifyListeners();
  }

  setTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
    // Save the selected theme using shared preferences
    prefs?.setInt("theme", mode.index);
  }

    void toggleTheme(bool isDark) {
    var mode = isDark ? ThemeMode.dark : ThemeMode.light;
    themeMode = mode;
    notifyListeners();
  }
}