import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/constants/app_images.dart';
import 'package:camels_go/core/func/nav_func.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/Auth/login/login_screen.dart';
import 'package:camels_go/view/home/home.dart';
import 'package:camels_go/view/shared/widgets/app_button.dart';
import 'package:camels_go/view/shared/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextEditingController _newPasswordTextEditingContorller =
    TextEditingController();
TextEditingController _confermNewPasswordTextEditingContorller =
    TextEditingController();

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: SizedBox(
          width: double.infinity,
          height: 800,
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
                    style: AppConstants.customTitleTextStyle.copyWith(
                      color: AppColors.main2Color,
                    ),
                    AppLocalizations.of(context)!.resetPassword),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    children: [
                      AppTextFormField(
                        borderRaduis: 10,
                        controller: _newPasswordTextEditingContorller,
                        onChanged: (p0) {},
                        validator: (p0) {},
                        shadow: true,
                        borderColor: AppColors.greyColor,
                        hintText: AppLocalizations.of(context)!.newPassword,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextFormField(
                        borderRaduis: 10,
                        controller: _confermNewPasswordTextEditingContorller,
                        onChanged: (p0) {},
                        validator: (p0) {},
                        shadow: true,
                        borderColor: AppColors.greyColor,
                        hintText:
                            AppLocalizations.of(context)!.confirmNewPassword,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  title: AppLocalizations.of(context)!.confirm,
                  textColor: Colors.white,
                  width: double.infinity,
                  borderRadius: 10,
                  backgroundColor: AppColors.mainColor,
                  onTap: () {
                    // validate
                    // if not valid show toast
                    // contorller.resetpassword
                    // clear controller or the textEditingControllers
                    navigateToWithReplacement(context, const HomeScreen());
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
                        fontSize: 20,
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
