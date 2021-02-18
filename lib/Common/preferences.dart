import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = new Preferences._internal();
  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
  SharedPreferences _prefs;

  init() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get mode {
    return _prefs.getBool('mode') ?? false;
  }

  set mode(bool value) {
    _prefs.setBool('mode', value);
  }
}
