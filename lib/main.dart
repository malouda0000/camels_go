import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // import 'generated/l10n.dart';
import 'package:camels_go/view/store/bloc/store_bloc.dart';
import 'package:camels_go/core/func/theme_repositores.dart';
import 'package:camels_go/core/helpers/cache_helper.dart';
import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/core/themes/bloc/theme_bloc.dart';
import 'package:camels_go/core/themes/bloc/theme_state.dart';
import 'package:camels_go/core/themes/custom_dark_themes.dart';
import 'package:camels_go/core/themes/custom_light_themes.dart';
import 'package:camels_go/view/Auth/bloc/auth_bloc.dart';
import 'package:camels_go/view/Auth/login/login_screen.dart';
import 'package:camels_go/view/dash_board/bloc/dashboard_bloc.dart';
import 'package:camels_go/view/dash_board/bloc/shipment_details_bloc.dart';
import 'package:camels_go/view/home/bloc/vendro_bloc/bloc/vendor_bloc.dart';
import 'package:camels_go/view/home/bloc/vendro_bloc/bloc/vendor_services.dart';
import 'package:camels_go/view/home/home.dart';
import 'package:camels_go/view/language/bloc/localization_bloc.dart';
import 'package:camels_go/view/onbording/bloc/onbording_bloc.dart';
import 'package:camels_go/view/order_follow/bloc/order_follow_bloc.dart';
import 'package:camels_go/view/payments/bloc/payments_bloc.dart';
import 'package:camels_go/view/personal%20profile/bloc/personal_profile_bloc.dart';
import 'package:camels_go/view/purchase_services/bloc/purchase_services_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? globalCachedUserToken = "";
// String? globalCachedTEMPUserToken =
// = "842|kfJ1xYx8xejTn9Oz9YNWRZUsx46l13v09X60PKhk29dc2055";
String? globalCachedUserLang;
String? globalCachedArabicUserName;
String? globalCachedEnglishUserName;
String? globalCachedUserImage = "";
String? globalCachedNationaltyID;
String? globalCachedNationaltyAr;
String? globalCachedNationaltyEn;
String? globalCachedUserBirthdate;
// String? globalCachedUserBirthdate;
int? globalCachedUserGender;

String? globalCachedUserID;
String? globalCachedUserPhoneNum;
String? globalCachedUserEmail;
String? globalCachedUserImageUserDoesntExiset =
    "https://thispersondoesnotexist.com/";
//  const String globalDefaltCachedNetworkImage = "https://www.istockphoto.com/illustrations/green-shopping-cart-icon";
// const String globalDefaltCachedNetworkImage =
//     "https://cdn4.iconfinder.com/data/icons/social-media-2070/140/_shopify-512.png";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainColor,

    statusBarIconBrightness: Brightness.dark, // Set icons to black
    statusBarBrightness: Brightness.light, // Adjust for iOS
  )); // Set the status bar color
  final ThemeRepository themeRepository = ThemeRepository();

  await CacheHelper.init();
  await DioHelper.init();
  // await Hive.initFlutter();
  runApp(MyApp(themeRepository: themeRepository));
}

class MyApp extends StatelessWidget {
  final ThemeRepository themeRepository;

  const MyApp({Key? key, required this.themeRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (context) => SubjectBloc(),
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<LocalizationBloc>(create: (context) => LocalizationBloc()),
        BlocProvider<OnbordingBloc>(create: (context) => OnbordingBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<DashboardBloc>(create: (context) => DashboardBloc()),
        BlocProvider<StoreBloc>(create: (context) => StoreBloc()),
        BlocProvider<ShipmentBloc>(create: (context) => ShipmentBloc()),
        BlocProvider<ShipmentDetailsBloc>(
            create: (context) => ShipmentDetailsBloc()),
        BlocProvider<PaymentsBloc>(create: (context) => PaymentsBloc()),
        BlocProvider<OrderFollowBloc>(create: (context) => OrderFollowBloc()),
        BlocProvider<PurchaseServicesBloc>(
            create: (context) => PurchaseServicesBloc()),
        BlocProvider<VendorBloc>(
            create: (context) => VendorBloc(VendorService(DioHelper.baseUrl))),
        BlocProvider<PersonalProfileBloc>(
            create: (context) => PersonalProfileBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocalizationBloc, LocalizationState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Special Line Vendor',
                debugShowCheckedModeBanner: false,
                theme: customLightTheme,
                darkTheme: customDarkTheme,
                themeMode: themeState.themeMode,
                locale: globalCachedUserLang == null
                    ? Locale("en")
                    : Locale(globalCachedUserLang!),
                supportedLocales: AppLocalizations.supportedLocales,

                localizationsDelegates: AppLocalizations.localizationsDelegates,
                // Set the initial route
                // home: (globalCachedUserToken!.isNotEmpty &&
                //         globalCachedUserToken != null &&
                //         globalCachedUserToken!.length > 5)
                //     ? HomeScreen()
                //     : LogInScreen(),

                // Set the initial route
                home: (globalCachedUserToken?.isNotEmpty ?? false)
                    ? HomeScreen()
                    : LogInScreen(),

                // const MyHomePage(title: 'Special Line Vendor'),
              );
            },
          );
        },
      ),
    );
  }
}

// #### +971569949467
// #### 1234
