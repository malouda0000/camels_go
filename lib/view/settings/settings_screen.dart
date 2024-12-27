import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/constants/app_images_svg.dart';
import 'package:camels_go/core/func/nav_func.dart';
import 'package:camels_go/core/helpers/cache_helper.dart';
import 'package:camels_go/core/helpers/user_expernce_helper.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/core/themes/bloc/theme_bloc.dart';
import 'package:camels_go/core/themes/bloc/theme_state.dart';
import 'package:camels_go/main.dart';
import 'package:camels_go/view/Auth/login/login_screen.dart';
import 'package:camels_go/view/bank%20accounts/user_bank_accounts_screen.dart';
import 'package:camels_go/view/language/bloc/localization_bloc.dart';
import 'package:camels_go/view/payments/payments.dart';
import 'package:camels_go/view/personal%20profile/personal_profile_screen.dart';
import 'package:camels_go/view/privcy%20policy/privcy_policy_screen.dart';
import 'package:camels_go/view/shared/screens/under_deve_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Container(
            height: 24,
            width: 24,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SettingsBody(),
      // body: Center(
      //   child: Text(AppLocalizations.of(context)!.settings),
      // ),
    );
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstants.emptySpaceTenPixl,
          AppConstants.emptySpaceTenPixl,
          AppConstants.emptySpaceTenPixl,
          AppConstants.emptySpaceTenPixl,
          // AppConstants.emptySpaceTenPixl,
          // Container(
          //   height: 100,
          //   width: double.infinity,
          //   color: AppColors.mainColor,
          // ),

          // ListTile(
          //   leading: SvgPicture.asset(
          //     AppImagesSvg.persion,
          //     height: 24,
          //     width: 24,
          //     color: AppColors.mainColor,
          //   ),
          //   title: Text(
          //     AppLocalizations.of(context)!.personalPage,
          //     style: TextStyle(
          //       fontSize: 20,
          //     ),
          //   ),

          // )

          CustomSettingListTile(
            title: AppLocalizations.of(context)!.personalPage,
            svgImageName: AppImagesSvg.persion,
            onTap: () {
              navigateTo(context, PersonalProfileScreen());
            },
          ),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.show_money,
            svgImageName: AppImagesSvg.cashPag,
            onTap: () {
              navigateTo(context, PaymentsScreen());
            },
          ),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.bank_accounts,
            svgImageName: AppImagesSvg.cash,
            onTap: () {
              navigateTo(context, UserBankAccountsScreen());
            },
          ),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.notifications,
            svgImageName: AppImagesSvg.bell,
            onTap: () {
              navigateTo(context, UnderDevScreen());
            },
          ),
          CustomSettingListTile(
              title: AppLocalizations.of(context)!.change_language,
              svgImageName: AppImagesSvg.language,
              // onTap: () async {
              //   if (globalCachedUserLang == "en") {
              //     BlocProvider.of<LocalizationBloc>(context)
              //         .add(LoadLocalizationEvent(Locale('ar')));
              //     print("ttttttttttttttttttttttt$globalCachedUserLang");
              //   }

              //   if (globalCachedUserLang == "ar") {
              //     BlocProvider.of<LocalizationBloc>(context)
              //         .add(LoadLocalizationEvent(Locale('en')));
              //     print("eeeeeeeeeeeeeeeeeeeeeeeeeeeee$globalCachedUserLang");
              //   }

              //   cachLocal(langCode: "ar");
              // },

              onTap: () {
                final newLocale =
                    globalCachedUserLang == "en" ? Locale('ar') : Locale('en');
                BlocProvider.of<LocalizationBloc>(context)
                    .add(LoadLocalizationEvent(newLocale));
              }),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return CustomSettingListTile(
                title: AppLocalizations.of(context)!.dark_mode,
                svgImageName: AppImagesSvg.dark,
                trailing: Transform.scale(
                  scale: .6,
                  child: CupertinoSwitch(

                      // activeColor: Colors.red,
                      // inactiveThumbColor: AppColors.darkBgColor,
                      // inactiveTrackColor: AppColors.darkBgColor,
                      // materialTapTargetSize: MaterialTapTargetSize.padded,
                      trackColor: AppColors.darkBgColor,
                      activeColor: AppColors.mainColor,
                      value: context.read<ThemeBloc>().state.themeMode ==
                          ThemeMode.dark,
                      onChanged: (isDark) {
                        // context.read<ThemeBloc>().toggleTheme();
                        context.read<ThemeBloc>().toggleTheme();
                      }),
                ),
                onTap: () {
                  context.read<ThemeBloc>().toggleTheme();
                },
              );
            },
          ),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.privacy_policy,
            svgImageName: AppImagesSvg.sheild,
            onTap: () {
              navigateTo(context, PrivcyPolicyScreen());
            },
          ),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.start_chat,
            svgImageName: AppImagesSvg.chat,
            onTap: () {
              navigateTo(context, UnderDevScreen());
            },
          ),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.share_app,
            svgImageName: AppImagesSvg.share,
            onTap: () {
              Share.share(
                '${AppLocalizations.of(context)!.share_app} https://play.google.com/store/apps/dev?id=6980730046981240737&hl=en',
                subject: AppLocalizations.of(context)!.specialLine,
              );
            },
          ),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.about_us,
            svgImageName: AppImagesSvg.people,
            onTap: () {
              navigateTo(context, PrivcyPolicyScreen());
            },
          ),
          CustomSettingListTile(
              title: AppLocalizations.of(context)!.contact_us,
              svgImageName: AppImagesSvg.phone,
              onTap: () async {
                const phoneNumber = 'tel:066353753';
                if (await canLaunch(phoneNumber)) {
                  await launch(phoneNumber);
                } else {
                  throw 'Could not launch $phoneNumber';
                }
              }),
          CustomSettingListTile(
            title: AppLocalizations.of(context)!.signOut,
            svgImageName: AppImagesSvg.signOut,
            haveDivider: false,
            onTap: () async {
              // navigateTo(context, UnderDevScreen());

              try {
                UserExperinceHelper().showCustomDialog(
                  theContext: context,
                  dialogContent: AppLocalizations.of(context)!.are_you_sure,
                  confirmButtonTitle: AppLocalizations.of(context)!.signOut,
                  onConfirm: () async { 
                    bool siiiignout = await CacheHelper.removeAllData();
                    // if (await signOut()) {
                    if (siiiignout == true) {
                      navigateToWithReplacement(context, const LogInScreen());
                    }
                  },
                );
              } catch (e) {
                // Handle any errors (optional, for logging/debugging)
                print("Error during sign out: $e");
              }
            },
          ),
          const SizedBox(
            height: 100,
            width: 20,
          )
        ],
      ),
    );
  }
}

class CustomSettingListTile extends StatelessWidget {
  final String? svgImageName, title;
  final bool? haveDivider;
  final Widget? trailing;
  final void Function()? onTap;

  CustomSettingListTile({
    super.key,
    required this.svgImageName,
    required this.title,
    this.haveDivider,
    this.trailing,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                svgImageName!,
                height: 24,
                width: 24,
                color: AppColors.mainColor,
                // fit: BoxFit.cover,
              ),
            ),
            title: Text(
              title!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                  ),
            ),
            trailing: trailing,
          ),
          haveDivider == false
              ? const SizedBox()
              : Divider(
                  // color: Colors.black.withOpacity(25), // Divider color
                  color: Colors.black.withOpacity(.25), // Divider color
                  thickness: 1, // Divider thickness
                  height: .5, // Space taken by the divider
                  // indent: 16, // Indent from the start
                  // endIndent: 16, // Indent from the end
                ),
        ],
      ),
    );
  }
}
