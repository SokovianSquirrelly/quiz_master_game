import 'package:flutter/cupertino.dart';
import 'package:quizmastergame/themePreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class ThemeModel extends ChangeNotifier{
  bool _isDark = false;
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark => _isDark;

  ThemeModel(){
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }
  getPreferences() async{
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }

  set isDark(bool value){
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }
}