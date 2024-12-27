// // theme_bloc.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:special_line_vendors/core/func/theme_repositores.dart';
// import 'theme_event.dart';
// import 'theme_state.dart';
// import 'package:flutter/services.dart'; // For SystemChrome

// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   final ThemeRepository themeRepository;

//   ThemeBloc({required this.themeRepository})
//       : super(const ThemeState(themeMode: ThemeMode.system)) {
//     on<LoadThemeEvent>(_onLoadTheme);
//     on<ToggleThemeEvent>(_onToggleTheme);
//     // Initialize by loading the theme
//     add(LoadThemeEvent());
//   }

//   Future<void> _onLoadTheme(
//       LoadThemeEvent event, Emitter<ThemeState> emit) async {
//     try {
//       final String? themeString = await themeRepository.getThemeMode();
//       if (themeString != null) {
//         // If theme is saved in preferences, use it
//         ThemeMode themeMode = _themeModeFromString(themeString);
//         emit(ThemeState(themeMode: themeMode));
//       } else {
//         // If no theme is saved, use system theme
//         // You can also force a specific theme if preferred
//         final Brightness systemBrightness =
//             WidgetsBinding.instance.window.platformBrightness;
//         ThemeMode systemThemeMode = systemBrightness == Brightness.dark
//             ? ThemeMode.dark
//             : ThemeMode.light;
//         emit(ThemeState(themeMode: systemThemeMode));
//       }
//     } catch (e) {
//       // In case of error, default to system theme
//       emit(const ThemeState(themeMode: ThemeMode.system));
//     }
//   }

//   Future<void> _onToggleTheme(
//       ToggleThemeEvent event, Emitter<ThemeState> emit) async {
//     try {
//       ThemeMode newThemeMode;
//       if (state.themeMode == ThemeMode.light) {
//         newThemeMode = ThemeMode.dark;
//       } else if (state.themeMode == ThemeMode.dark) {
//         newThemeMode = ThemeMode.light;
//       } else {
//         // If system, toggle to light
//         newThemeMode = ThemeMode.light;
//       }
//       print("theeeeeeeeeeeeeeeeeeeeeeeeeeeeemmm$newThemeMode");

//       // Save the new theme mode to preferences
//       await themeRepository.saveThemeMode(_themeModeToString(newThemeMode));

//       // Emit the new theme mode
//       emit(ThemeState(themeMode: newThemeMode));
//     } catch (e) {
//       // Handle error if needed
//     }
//   }

//   // Helper method to convert ThemeMode to String
//   String _themeModeToString(ThemeMode themeMode) {
//     switch (themeMode) {
//       case ThemeMode.light:
//         return 'light';
//       case ThemeMode.dark:
//         return 'dark';
//       case ThemeMode.system:
//       default:
//         return 'system';
//     }
//   }

//   // Helper method to convert String to ThemeMode
//   ThemeMode _themeModeFromString(String themeString) {
//     switch (themeString) {
//       case 'light':
//         return ThemeMode.light;
//       case 'dark':
//         return ThemeMode.dark;
//       case 'system':
//       default:
//         return ThemeMode.system;
//     }
//   }
// }

import 'package:camels_go/core/helpers/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeBloc extends Cubit<ThemeState> {
  static const _themeModeKey = 'themeMode';

  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {
    _loadTheme();
  }

  void _loadTheme() {
    final cachedTheme = CacheHelper.getData(key: _themeModeKey);
    final themeMode = cachedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(themeMode: themeMode));
  }

  void toggleTheme() {
    final newThemeMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    CacheHelper.saveData(key: _themeModeKey, value: newThemeMode.name);
    emit(state.copyWith(themeMode: newThemeMode));
  }
}
