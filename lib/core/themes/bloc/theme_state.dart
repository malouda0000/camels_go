// // theme_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// class ThemeState extends Equatable {
//   final ThemeMode themeMode;

//   const ThemeState({required this.themeMode});

//   @override
//   List<Object> get props => [themeMode];

//   printingTheThemeModeFunction() {
//     print("------------------------------%${themeMode}");
//   }
// }



import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState({required this.themeMode});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }
}
