import 'package:flutter/cupertino.dart';
import 'package:quizmastergame/themePreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class ThemeModel extends ChangeNotifier{
  //this is for turning on dark mode or light mode.
  bool _isDark = false;
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark => _isDark;

  //bring codes to other classes
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