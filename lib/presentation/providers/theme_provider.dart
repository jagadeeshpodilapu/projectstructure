import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  Future<void> toggleTheme() async {
    loadPreferredTheme();
  }

  void loadPreferredTheme() async {}
}
