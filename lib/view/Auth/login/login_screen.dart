// ignore_for_file: prefer_const_constructors

import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/constants/app_images.dart';
import 'package:camels_go/core/func/nav_func.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/Auth/bloc/auth_bloc.dart';
import 'package:camels_go/view/Auth/forget%20password%20screen/forget_password_screen.dart';
import 'package:camels_go/view/Auth/register/register_screen.dart';
import 'package:camels_go/view/Auth/register/widgets/auth_custom_icon.dart';
import 'package:camels_go/view/home/home.dart';
import 'package:camels_go/view/shared/screens/error_screen.dart';
import 'package:camels_go/view/shared/screens/loading_screen.dart';
import 'package:camels_go/view/shared/screens/under_deve_screen.dart';
import 'package:camels_go/view/shared/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextStyle _customLocalTextStyle = const TextStyle(
  color: Colors.black,
  height: .8,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

final TextEditingController signInUserEmailTextEditingController =
    TextEditingController();
final TextEditingController signInPasswordTextEditingController =
    TextEditingController();

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 180,
                width: 20,
              ),
              AuthCustomIcon(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener

                    if (state is AuthSuccessStateSignIn) {
                      showToast(
                          message:
                              // "${AppLocalizations.of(context)!.signInWelcome}: ${context.read<AuthBloc>().cashedArabicUserName != null ? context.read<AuthBloc>().cashedArabicUserName! : " "}");

                              AppLocalizations.of(context)!
                                  .welcome_to_special_line);
                      // AppCubit.get(context).getUser();
                      navigateToWithReplacement(
                        context,
                        const HomeScreen(),
                      );
                    }

                    if (state is AuthErrorStateSignIn) {
                      // context.loaderOverlay.hide();
                      showToast(
                        message: state.errorMessage,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingStateSignIn) {
                      return Center(
                        child: const SizedBox(
                            width: 300,
                            height: 700,
                            child: CustomLoadingScreen()),
                      );
                    } else if (state is AuthErrorStateSignIn) {
                      return Center(
                        child: SizedBox(
                            width: 300,
                            height: 700,
                            child:
                                ErrorScreen(errorMessage: state.errorMessage)),
                      );
                    }

                    // else if (state is AuthInitialState )
                    // {return CustomLoadingScreen();}

                    // else if (state is AuthSuccessState )
                    // {return _LoginBody();}

                    else {
                      return _LoginBody();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody({
    super.key,
  });

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Form(
          key: signInFormKey,
          child: Column(
            children: [
              _EmailOrPhoneNumFeild(),
              SizedBox(
                height: 20,
              ),
              _passwordTextFeild(),
              SizedBox(
                height: 20,
              ),
              _ForgetRestPasswordRow(),
              SizedBox(
                height: 20,
              ),
              _SignInButton(),
              // ElevatedButton(
              //   onPressed: () {
              //     // context.read<ThemeBloc>().add(ToggleThemeEvent());
              //   },
              //   child: const Text('Toggle Theme'),
              // ),
              SizedBox(
                height: 30,
              ),
              // _DepugSign(),
              // SizedBox(
              //   height: 30,
              // ),
              _DontHaveAccountButton(),
              SizedBox(
                height: 30,
              ),
              _CustomOrRow(),
              SizedBox(
                height: 30,
              ),
              _SocialMediaAuth(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialMediaAuth extends StatelessWidget {
  const _SocialMediaAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UnderDevScreen()));
          },
          child: const Image(
              image: AssetImage(
            AppImages.facebook,
          )),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UnderDevScreen()));
          },
          child: const Image(
              image: AssetImage(
            AppImages.google,
          )),
        ),
      ],
    );
  }
}

class _CustomOrRow extends StatelessWidget {
  const _CustomOrRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Divider(
            // thickness: 15,
            // height: 30,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          style: TextStyle(
            color: AppColors.greyColor,
            fontSize: 12,
          ),
          AppLocalizations.of(context)!.orByUsing,
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}

class _DontHaveAccountButton extends StatelessWidget {
  const _DontHaveAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UnderDevScreen()));
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignupScreen()),
              (route) => false);
        },
        child: Text(
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 12,
            ),
            AppLocalizations.of(context)!.youDontHaveAccount),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        10,
      ),
      onTap: () {
        // signInFormKey.currentState!.validate() == true
        //     ? print("${signInFormKey.currentState!.validate()}")
        //     : print("${signInFormKey.currentState!.validate()}");
        if (signInFormKey.currentState!.validate() == true) {
          context.read<AuthBloc>().add(AuthLogInEvent(
                theContext: context,
              ));
        }

        // print(
        //     "==============================${signInFormKey.currentState!.validate()}");
      },
      child: Container(
        height: 40,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          AppLocalizations.of(context)!.signIn,
        ),
      ),
    );
  }
}

class _ForgetRestPasswordRow extends StatelessWidget {
  const _ForgetRestPasswordRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            navigateToWithReplacement(context, const ForgotPasswordScreen());
          },
          child: Text(
            style: TextStyle(
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? AppColors.mainColor
                      : AppColors.darkBgColor,
              fontSize: 12,
            ),
            AppLocalizations.of(context)!.forgotPassword,
          ),
        ),
        InkWell(
          onTap: () {
            navigateToWithReplacement(context, const ForgotPasswordScreen());
          },
          child: Text(
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 12,
            ),
            AppLocalizations.of(context)!.resetPassword,
          ),
        ),
      ],
    );
  }
}

class _EmailOrPhoneNumFeild extends StatelessWidget {
  const _EmailOrPhoneNumFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // email or phone number
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // boxShadow: AppConstants.theLightBoxShdow,
        border: AppConstants.customBorderOnePixel,
        color: Colors.white,
      ),
      child: TextFormField(
        // name: AppLocalizations.of(context)!.email,
        // validator: (value) {
        //   // context.read<AuthBloc>().validateEmail(value);
        //   context.read<AuthBloc>().customValidator(value);
        // },

        //                 validator: FormBuilderValidators.compose([
        //      /// Makes this field required
        //      FormBuilderValidators.required(),

        //     /// Ensures the value entered is numeric - with a custom error message
        //     FormBuilderValidators.numeric(errorText: 'La edad debe ser numérica.'),

        //     /// Sets a maximum value of 70
        //     FormBuilderValidators.max(70),

        //     /// Include your own custom `FormFieldValidator` function, if you want
        //     /// Ensures positive values only. We could also have used `FormBuilderValidators.min(0)` instead
        //     (value) {
        //          final number = int.tryParse(value!);
        //         if (number == null) return null;
        //         if (number < 0) return 'We cannot have a negative age';
        //         return null;
        //     },
        // ]),

        // validator: (emailOrPhoneNum) {
        // emailOrPhoneNum!.length < 5 ? 'falsssse' : null;
        // print(emailOrPhoneNum);
        // emailOrPhoneNum == null
        // },

        // #### fully working validator #### //
        // #### #### //
        validator: (value) {
          final phoneExp = RegExp(r'^\+?1?\d{9,15}$');
          // print("vvvvvvvvvvvvvvvvvvvvvvvv${value.runtimeType}");
          if (value == null || value.isEmpty) {
            return 'Please enter a phone number';
          }

          if (value.length < 3) {
            return 'Password must be at least 9 characters long';
          }

          // if (!phoneExp.hasMatch(value)) {
          //   return 'Please enter a trueee phone number';
          // }
          return null;
        },
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            height: .8,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black),
        controller: signInUserEmailTextEditingController,
        decoration: InputDecoration(
          // the hint text was S.email but i change it for S.phoneNumber
          hintText: AppLocalizations.of(context)!.email,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              height: .8,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black),
          border: InputBorder.none,
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}

class _passwordTextFeild extends StatelessWidget {
  const _passwordTextFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // password text field

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // boxShadow: AppConstants.theLightBoxShdow,
        border: AppConstants.customBorderOnePixel,
        color: Colors.white,
      ),
      child: FormBuilderTextField(
        // password text field
        name: AppLocalizations.of(context)!.password,
        controller: signInPasswordTextEditingController,
        // #### fully working validator #### //
        // #### #### //
        validator: (value) {
          // final passwordExp = RegExp(
          //     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[@$.!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }

          if (value.length < 6) {
            return 'Password must be at least 8 characters long';
          }

          // if (!passwordExp.hasMatch(value)) {
          //   return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';

          //   // return UserExperinceHelper().showCustomDialog(
          //   //   theContext: context,
          //   //   confirmButtonTitle: AppLocalizations.of(context)!.confirm,
          //   //   dialogContent:
          //   //       'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
          //   // );
          // }
          return null;
        },
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              height: .8,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.password,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // color: Colors.black,
                height: .8,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
          border: InputBorder.none,
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}


// class _DepugSign extends StatelessWidget {
//   const _DepugSign({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(
//         50,
//       ),
//       onTap: () {
//         navigateToWithReplacement(context, const HomeScreen());
//       },
//       child: Container(
//         height: 40,
//         width: 200,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: AppColors.greyColor,
//             borderRadius: BorderRadius.circular(
//               50,
//             )),
//         child: Text(
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//             "debug sign"),
//       ),
//     );
//   }
// }
