import 'package:flutter/material.dart';

class ContentProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _darkMode = false;

  int get selectedIndex {
    return _selectedIndex;
  }

  set selectedIndex(int value) {
    this.selectedIndex = value;
    notifyListeners();
  }

  bool get darkMode {
    return this._darkMode;
  }

  set darkMode(bool value) {
    this._darkMode = value;
    notifyListeners();
  }

  initDarkMode(bool value) {
    this.darkMode = value;
  }
}
