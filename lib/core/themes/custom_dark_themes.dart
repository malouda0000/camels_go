import 'package:camels_go/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData customDarkTheme = ThemeData(
  useMaterial3: true,
  // Defines the page transition animations used by MaterialPageRoute
  // for different target platforms.
  // Non-specified target platforms will default to
  // ZoomPageTransitionsBuilder().
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
    },
  ),
  //
  //
  // brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColors.mainColor),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.mainColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: AppColors.mainColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.darkBgColor,
      fontWeight: FontWeight.w500,
      letterSpacing: 1,
      fontFamily: 'Cairo',
    ),
    iconTheme: IconThemeData(
      color: AppColors.darkBgColor,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.darkBgColor,
  fontFamily: 'Cairo',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.mainColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.mainColor,
    unselectedItemColor: Colors.black45,
    selectedLabelStyle: TextStyle(
      fontFamily: 'Cairo',
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: 'Cairo',
    ),
  ),
  // Set default text color to white
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
  ),

// cardTheme: const CardTheme(
//   color: AppColors.darkCardColor,
//   elevation: 2,
//   margin: EdgeInsets.all(8),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.all(Radius.circular(12)),
//   ),
// ),

// buttonTheme: const ButtonThemeData(
//   buttonColor: AppColors.mainColor,
//   textTheme: ButtonTextTheme.primary,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//   ),
// ),

// inputDecorationTheme: const InputDecorationTheme(
//   filled: true,
//   fillColor: AppColors.darkInputColor,
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: AppColors.mainColor),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: AppColors.mainColor, width: 2),
//   ),
//   labelStyle: TextStyle(color: Colors.white70),
//   hintStyle: TextStyle(color: Colors.white54),
// ),
);
