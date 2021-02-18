import 'package:flutter/material.dart';

class MainTheme {
  static final _primary = Colors.indigo;
  static final _primaryDark = Colors.blue;
  static final _primaryAccent = Colors.amberAccent;
  static final _buttonColor = Colors.lightBlueAccent;

  Color get primary {
    return _primary;
  }

  Color get primaryDark {
    return _primaryDark;
  }

  Color get primaryAccent {
    return _primaryAccent;
  }

  static setup(bool mode) {
    return ThemeData(
        colorScheme: ColorScheme(
            primary: _primary,
            primaryVariant: _primaryDark,
            secondary: _primaryDark,
            secondaryVariant: _primaryDark,
            surface: _primaryDark,
            background: _primaryDark,
            error: _primaryDark,
            onPrimary: _primaryDark,
            onSecondary: _primaryDark,
            onSurface: _primaryDark,
            onBackground: _primaryDark,
            onError: _primaryDark,
            brightness: mode ? Brightness.dark : Brightness.light),
        primaryColor: _primary,
        primaryColorDark: _primaryDark,
        buttonColor: _buttonColor,
        accentColor: _primaryAccent);
  }
}
