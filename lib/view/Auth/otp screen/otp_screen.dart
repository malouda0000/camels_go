import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/constants/app_images.dart';
import 'package:camels_go/core/func/nav_func.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/Auth/login/login_screen.dart';
import 'package:camels_go/view/Auth/new%20password%20screen/new_password_screen.dart';
import 'package:camels_go/view/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: SizedBox(
          width: double.infinity,
          height: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(width: 160, AppImages.logoLight),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    style: AppConstants.customTitleTextStyle,
                    AppLocalizations.of(context)!.resetPassword),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  style: const TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 20,
                  ),
                  AppLocalizations.of(context)!.otpCodeSended,
                ),
                const Text(
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 20,
                  ),
                  'mhli.outlook.sa@gmail.com',
                ),
                const SizedBox(
                  height: 20,
                ),
                OtpTextField(
                  numberOfFields: 4,
                  showFieldAsBox: true,
                  borderRadius: AppConstants.theTenPXBorderRadius,
                  borderWidth: 2,
                  fieldHeight: 60,
                  fieldWidth: 60,
                  enabledBorderColor: AppColors.greyColor,
                  focusedBorderColor: AppColors.mainColor,
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        });
                  }, // end onSubmit
                ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  title: AppLocalizations.of(context)!.sendCode,
                  textColor: Colors.white,
                  borderRadius: 10,
                  width: double.infinity,
                  backgroundColor: AppColors.mainColor,
                  onTap: () {
                    // validate
                    // make sure the otp length is 4, if it's not then show custom
                    // toast saying the otp is shorter
                    // contorller.check otp

                    navigateToWithReplacement(
                        context, const NewPasswordScreen());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      navigateToWithReplacement(context, const LogInScreen());
                    },
                    child: Text(
                      style: AppConstants.customTitleTextStyle.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 14,
                      ),
                      AppLocalizations.of(context)!.backToSignIn,
                    )),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
