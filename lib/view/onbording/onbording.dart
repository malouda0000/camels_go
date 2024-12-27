// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:camels_go/core/constants/app_images.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/Auth/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class CustomOnBordingPageViewBuilder extends StatelessWidget {
  const CustomOnBordingPageViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(OnBordingControllerImp());
    return Scaffold(
      // backgroundColor: AppColor.kPrimaryColor,
      body: SafeArea(
        child: OnBoardingSlider(
          finishButtonText: AppLocalizations.of(context)!.signUp,
          onFinish: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignupScreen(),
              ),
            );
          },
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: AppColors.mainColor,
          ),
          // skipTextButton: Text(
          //   AppLocalizations.of(context)!.skip,
          //   // "skip",
          //   style: TextStyle(
          //     fontSize: 16,
          //     color: AppColors.mainColor,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          trailing: Text(
            AppLocalizations.of(context)!.signIn,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.mainColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailingFunction: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => LogInScreen(),
            //   ),
            // );

            // context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
          controllerColor: AppColors.mainColor,

          totalPage: 3,
          // headerBackgroundColor: Colors.transparent,
          headerBackgroundColor: Colors.white,
          pageBackgroundColor: Colors.white,
          background: [
            Image.asset(
              AppImages.onbording1,
              height: 400,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Image.asset(
              AppImages.onbording2,
              height: 400,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Image.asset(
              AppImages.onbording3,
              height: 400,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ],
          speed: 1.8,
          pageBodies: [
            Container(
              // color: Colors.red,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                // this just to solve the problem of the text (description text) overflow
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 480,
                    ),
                    Text(
                      AppLocalizations.of(context)!.shipping_and_delivery,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Text(
                          AppLocalizations
                              .of(context)
                              !
                              .integrated_delivery_and_technology_services,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    AppLocalizations.of(context)!.shipping_and_delivery,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .integrated_delivery_and_technology_services,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    AppLocalizations.of(context)!.confirm,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .integrated_delivery_and_technology_services,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
