

import 'package:camels_go/core/helpers/cache_helper.dart';

class ThemeRepository {
  static const String _themeKey = 'theme_mode';

  // Save the theme mode to shared preferences
  Future<void> saveThemeMode(String themeMode) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString(_themeKey, themeMode);
    await CacheHelper.setData(key: _themeKey, value: themeMode);
  }

  // Get the theme mode from shared preferences
  Future<String?> getThemeMode() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getString(_themeKey);
    return await CacheHelper.getData(key: _themeKey);

  }
}
