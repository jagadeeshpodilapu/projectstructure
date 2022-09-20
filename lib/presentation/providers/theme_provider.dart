
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Future<void> toggleTheme() async {
    loadPreferredTheme();
  }

  void loadPreferredTheme() async {}
}
