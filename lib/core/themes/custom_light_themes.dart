import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camels_go/core/themes/app_colors.dart';

ThemeData customLightTheme = ThemeData(
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
  // brightness: Brightness.light,

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
    // iconTheme: IconThemeData(color: AppColors.mainGreyColor),
    iconTheme: IconThemeData(color: AppColors.darkBgColor),
  ),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Cairo',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.mainColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.mainColor,
    // unselectedItemColor: AppColors.mainGreyColor,
    unselectedItemColor: AppColors.lightGrayColor,
    selectedIconTheme: IconThemeData(),
    selectedLabelStyle: TextStyle(
      fontFamily: 'Cairo',
      color: AppColors.mainColor,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      // color: AppColors.mainGreyColor,
      color: AppColors.lightGrayColor,
      fontFamily: 'Cairo',
    ),
  ),

  textTheme: const TextTheme(
    // bodyLarge: TextStyle(color: AppColors.blackColor),
    bodyMedium: TextStyle(color: AppColors.blackColor),
    // bodySmall: TextStyle(color: AppColors.darkGreyColor),
    // headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.blackColor),
    // headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.blackColor),
    // headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.blackColor),
    // titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blackColor),
    // titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.blackColor),
    // titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.darkGreyColor),
    // labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.mainColor),
    // labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.mainColor),
    // labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.lightGrayColor),
  ),

// cardTheme: const CardTheme(
//   color: Colors.white,
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
//   fillColor: AppColors.lightGrayColor,
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: AppColors.mainColor),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: AppColors.mainColor, width: 2),
//   ),
//   labelStyle: TextStyle(color: AppColors.darkGreyColor),
//   hintStyle: TextStyle(color: AppColors.lightGrayColor),
// ),
);
