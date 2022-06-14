import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../static/theme.dart';

class ThemeUtils {
  Future<void> saveTheme(int themeIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("color", themeIndex);
  }

   Future<MaterialColor>getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Static.colors[prefs.getInt("color") ?? 0];
  }
}
