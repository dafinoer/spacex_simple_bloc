import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPrefPage {

  final String _themeMode = 'modeTheme';

  Future<void>setPrefDark(bool value) async {
    final sharedpf = await SharedPreferences.getInstance();
    sharedpf.setBool(_themeMode, value);
  }

  Future<bool> getThemePref() async {
    final sharedprefmode = await SharedPreferences.getInstance();
    return sharedprefmode.getBool(_themeMode);
  }

}