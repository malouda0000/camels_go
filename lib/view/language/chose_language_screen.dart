// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:select_shop/core/functions/localization.dart';
// import 'package:select_shop/core/functions/nav_func.dart';
// import 'package:select_shop/core/theme/colors.dart';
// import 'package:select_shop/view/Auth/login_screen.dart';
// import 'package:select_shop/view/Shared/app_button.dart';
// import 'package:select_shop/view/language/bloc/localization_bloc.dart';

// class ChoseLanguageScreen extends StatefulWidget {
//   final bool commingFromSettings;
//   const ChoseLanguageScreen({super.key, required this.commingFromSettings});

//   @override
//   State<ChoseLanguageScreen> createState() => _ChoseLanguageScreenState();
// }

// class _ChoseLanguageScreenState extends State<ChoseLanguageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               AppButton(
//                 title: "العربيه",
//                 width: double.infinity,
//                 hasBorder: true,
//                 backgroundColor: Localizations.localeOf(context) == Locale('en')
//                     ? AppColors.mainColor
//                     : Colors.white,
//                 textColor: Localizations.localeOf(context) == Locale('en')
//                     ? Colors.white
//                     : AppColors.mainColor,
//                 onTap: () async {
//                   // set app language
// //                   await changeLocal(langCode: 'ar');
// //                   setState(() {});

// // // MyApp.of(context).setLocale
//                   BlocProvider.of<LocalizationBloc>(context)
//                       .add(LoadLocalizationEvent(Locale('ar')));

//                   cachLocal(langCode: "ar");
//                   widget.commingFromSettings == true
//                       ? null
//                       : navigateTo(context, const LogInScreen());
// //                   print(
// //                       'arrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'); // then navigate to logIn screen
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               AppButton(
//                 title: "English",
//                 width: double.infinity,
//                 hasBorder: true,
//                 backgroundColor: Localizations.localeOf(context) == Locale('ar')
//                     ? AppColors.mainColor
//                     : Colors.white,
//                 textColor: Localizations.localeOf(context) == Locale('ar')
//                     ? Colors.white
//                     : AppColors.mainColor,
//                 onTap: () async {
//                   // set app language

//                   // Localizations.of(context, type)

//                   // await changeLocal(langCode: 'en');
//                   // setState(() {});

//                   BlocProvider.of<LocalizationBloc>(context)
//                       .add(LoadLocalizationEvent(Locale('en')));

//                   cachLocal(langCode: "ar");

//                   widget.commingFromSettings == true
//                       ? null
//                       : navigateTo(context, const LogInScreen());

//                   // print('ennnnnnnnnnnngliiiiiiiiiiiiiiiiiiiiish');
//                   // then navigate to logIn screen
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
