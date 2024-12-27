import 'dart:async';

import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/helpers/cache_helper.dart';
import 'package:camels_go/main.dart';
import 'package:flutter/material.dart';

// changeLocal()async {
// Locale appLocal = await CacheHelper.getData(key: 'local');
// // Locale appLocal = Locale('en');
// print(appLocal);

// }

// Future<Locale>
// getLocal() async {
// // Locale appLocal =
// //  if (await CacheHelper.getData(key: 'local') == null || await CacheHelper.getData(key: 'local') == "" ) {

// //    Locale('en');

// // }else {
// //     Locale(await CacheHelper.getData(key: 'local') );
// // };
// // // Locale appLocal = Locale('en');

// // print(appLocal);
// // return appLocal;

//   Locale initalLang =
//       CacheHelper.getData(key: 'lang') == 'en' ? Locale('en') : Locale('ar');

//   return initalLang;
//   // String emailVerLang() {
//   //   return CacheHelper.getData(key:'lang') == 'en' ? 'en' : 'ar';
//   // }
// }

cachLocal({required String langCode}) async {
  // Locale myLocale = Locale(langCode);

  // Get.updateLocale(myLocale);

  await CacheHelper.setData(key: AppConstants.cachedUserLang, value: langCode);

  globalCachedUserLang = langCode; // RestartWidget.restartApp(context);
}
