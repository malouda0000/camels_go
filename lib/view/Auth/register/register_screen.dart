// ignore_for_file: prefer_const_constructors

import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/func/nav_func.dart';
import 'package:camels_go/core/helpers/user_expernce_helper.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/view/Auth/bloc/auth_bloc.dart';
import 'package:camels_go/view/Auth/register/widgets/auth_custom_icon.dart';
import 'package:camels_go/view/home/home.dart';
import 'package:camels_go/view/shared/screens/error_screen.dart';
import 'package:camels_go/view/shared/screens/loading_screen.dart';
import 'package:camels_go/view/shared/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part "widgets/signup_widgets.dart";

bool _obscuringTextOrNot = true;
bool? _userAgreementChecked = false;
// final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

// Key? _userAgrementRowKey = Key()?;

TextEditingController signUPArbUserNameTextEditingContorller =
    TextEditingController();
TextEditingController signUPEngUserNameTextEditingContorller =
    TextEditingController();
TextEditingController signUpUserEmailTextEditingController =
    TextEditingController();
TextEditingController signUpUserPhonNumTextEditingController =
    TextEditingController();
TextEditingController signUpPasswordTextEditingController =
    TextEditingController();
TextEditingController signUpconfirmPassTexEdiController =
    TextEditingController();

TextStyle _customLocalTextStyle = const TextStyle(
  height: .8,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        // TODO: implement listener

                        if (state is AuthSuccessStateSignUp) {
                          showToast(
                              message:
                                  "${AppLocalizations.of(context)!.signUpSuccess}: ${context.read<AuthBloc>().cashedArabicUserName != null ? context.read<AuthBloc>().cashedArabicUserName! : " "}");
                          // AppCubit.get(context).getUser();
                          navigateToWithReplacement(
                            context,
                            const HomeScreen(),
                          );
                        }

                        // if (state is AuthErrorStateSignIn) {
                        //   // context.loaderOverlay.hide();
                        //   showToast(
                        //     message: state.errorMessage,
                        //   );

                        //   // Duration(seconds: 5 ) ;
                        //   // context.read<AuthBloc>().add(AuthInitialState());
                        // }
                      },
                      builder: (context, state) {
                        if (state is AuthLoadingStateSignUp) {
                          return Center(
                            child: const SizedBox(
                                width: 200,
                                height: 200,
                                child: CustomLoadingScreen()),
                          );
                        } else if (state is AuthErrorStateSignUp) {
                          return SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ErrorScreen(errorMessage: state.errorMessage),
                              ],
                            ),
                          );
                        }

                        // else if (state is AuthInitialState )
                        // {return CustomLoadingScreen();}

                        // else if (state is AuthSuccessStateSignUp )
                        // {return _SignUpBody(context);}

                        else {
                          return _SignUpBody(context);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Form _SignUpBody(BuildContext context) {
    return Form(
        key: signUpKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const _UserNameArbFormFeild(),
            const SizedBox(
              height: 20,
            ),
            const _UserNameEngFormFeild(),
            const SizedBox(
              height: 20,
            ),
            _UserEmailFormFeild(),
            const SizedBox(
              height: 20,
            ),
            _UserPhonNumText(),
            const SizedBox(
              height: 20,
            ),
            _passwordFormFeild(context),
            const SizedBox(
              height: 20,
            ),
            _confirmPasswordFormFeild(context),
            const SizedBox(
              height: 20,
            ),
            // _UserAggrementRow(context),
            _userAggrementRow(context),
            const SizedBox(
              height: 20,
            ),
            _SignUpButton(
              theScreenContext: context,
            ),
            const SizedBox(
              height: 30,
            ),
            const _DepugSign(),
            const SizedBox(
              height: 30,
            ),
            const _DoYouHaveAccount(),
            const SizedBox(
              height: 30,
            ),
            const _OrSignUpWithGoogle(),
            const SizedBox(
              height: 30,
            ),
            _GoogleIcons(),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }

  Row _userAggrementRow(BuildContext context) {
    return Row(
      // key: signUpKey,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: AppColors.mainColor, // color of the border
          ),
          child: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(width: 1.0, color: AppColors.mainColor),
            ),
            activeColor: AppColors.mainColor,
            value: _userAgreementChecked,
            onChanged: (value) {
              _userAgreementChecked = value;

              setState(() {});
            },
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.userAgrement,
                textAlign: TextAlign.center,

                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                // softWrap: true,

                style: TextStyle(
                  // color: AppColors.mainGreyColor,
                  fontSize: 12,
                ),
                // overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Row _UserAggrementRow(BuildContext context) {
  //   return Row(
  //     // key: signUpKey,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Theme(
  //         data: Theme.of(context).copyWith(
  //           unselectedWidgetColor: AppColors.mainColor, // color of the border
  //         ),
  //         child: Checkbox(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(5.0),
  //           ),
  //           side: MaterialStateBorderSide.resolveWith(
  //             (states) => BorderSide(width: 1.0, color: AppColors.mainColor),
  //           ),
  //           activeColor: AppColors.mainColor,
  //           value: _userAgreementChecked,
  //           onChanged: (value) {
  //             _userAgreementChecked = value;

  //             setState(() {});
  //           },
  //         ),
  //       ),
  //       Expanded(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Text(
  //               AppLocalizations.of(context)!.userAgrement,
  //               textAlign: TextAlign.center,

  //               overflow: TextOverflow.ellipsis,
  //               maxLines: 2,
  //               // softWrap: true,

  //               style: TextStyle(
  //                 color: AppColors.mainGreyColor,
  //                 fontSize: 12,
  //               ),
  //               // overflow: TextOverflow.visible,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Container _confirmPasswordFormFeild(BuildContext context) {
    return Container(
      // confirm password feild
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50,
          ),
          // boxShadow: AppConstants.theLightBoxShdow,
          border: AppConstants.customBorderOnePixel,
          color: Colors.white),
      child: FormBuilderTextField(
        name: AppLocalizations.of(context)!.confirmNewPassword,
        keyboardType: TextInputType.visiblePassword,
        style: _customLocalTextStyle,

        obscureText: _obscuringTextOrNot,
        controller: signUpconfirmPassTexEdiController,
        // #### fully working validator #### //
        // #### #### //
        validator: (value) {
          // final passwordExp = RegExp(
          //     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }

          if (value.length < 8) {
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

          if (signUpPasswordTextEditingController.text !=
              signUpconfirmPassTexEdiController.text) {
            return 'passwords are not the same';
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.confirmNewPassword,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // color: AppColors.greyColor,
                height: .8,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          border: InputBorder.none,
          suffix: InkWell(
            child: _obscuringTextOrNot == true
                ? FaIcon(
                    FontAwesomeIcons.eyeLowVision,
                    color: AppColors.greyColor,
                  )
                : FaIcon(
                    FontAwesomeIcons.eye,
                    color: AppColors.greyColor,
                  ),
            onTap: () {
              setState(() {
                _obscuringTextOrNot == true
                    ? _obscuringTextOrNot = false
                    : _obscuringTextOrNot = true;
              });
            },
          ),
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Container _passwordFormFeild(BuildContext context) {
    return Container(
      // password feild
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          50,
        ),
        // boxShadow: AppConstants.theLightBoxShdow,
        border: AppConstants.customBorderOnePixel,
        color: Colors.white,
      ),
      child: FormBuilderTextField(
        name: AppLocalizations.of(context)!.password,
        keyboardType: TextInputType.visiblePassword,
        style: _customLocalTextStyle,
        obscureText: _obscuringTextOrNot == true ? true : false,
        controller: signUpPasswordTextEditingController,
        // #### fully working validator #### //
        // #### #### //
        validator: (value) {
          // final passwordExp = RegExp(
          //     r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }

          if (value.length < 8) {
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

          if (signUpPasswordTextEditingController.text !=
              signUpconfirmPassTexEdiController.text) {
            return 'passwords are not the same';
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.password,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // color: AppColors.greyColor,
                height: .8,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          border: InputBorder.none,
          suffix: InkWell(
            child: _obscuringTextOrNot == true
                ? FaIcon(
                    FontAwesomeIcons.eyeLowVision,
                    color: AppColors.greyColor,
                  )
                : FaIcon(
                    FontAwesomeIcons.eye,
                    color: AppColors.greyColor,
                  ),
            onTap: () {
              setState(() {
                _obscuringTextOrNot == true
                    ? _obscuringTextOrNot = false
                    : _obscuringTextOrNot = true;
              });
            },
          ),
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 20,
            vertical: 0,
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatefulWidget {
  // final GlobalKey<FormState> signUpKey;
  final BuildContext theScreenContext;
  const _SignUpButton({
    super.key,
    // required this.signUpKey,
    required this.theScreenContext,
  });

  @override
  State<_SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<_SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        50,
      ),
      onTap: () async {
        // make sure the form is valid
        // and the user aggread to all the privicy policy

        // signUpKey.currentState!.setState(() {
        //   // _userAgreementChecked = true;
        //   print("sssssssssssssssssssssssssssssssss");
        // });

        // #### form validation #### //
        if (signUpKey.currentState!.validate() == true
            // &&  _userAgreementChecked == true
            ) {
          // #### check user agrement #### //
          if (_userAgreementChecked == false) {
            UserExperinceHelper().showCustomDialog(
                theContext: widget.theScreenContext,
                dialogContent: AppLocalizations.of(context)!.userAgrement,
                confirmButtonTitle: "ok",
                onConfirm: () async {
                  // setState(() {
                  //   _userAgreementChecked = true;
                  //   // context: the

                  // });

                  // signUpKey.currentState!.setState(() {
                  //   _userAgreementChecked = true;
                  //   print("sssssssssssssssssssssssssssssssss");
                  // });
                  // sign
                  setState(() {});
                  // widget.theScreenContext.widget.

                  Navigator.of(context).pop();
                });
          }

          // #### every thing is true #### //
          if (_userAgreementChecked == true) {
            context.read<AuthBloc>().add(AuthSignupEvet(
                  theContext: context,
                ));
          }
        }
      },
      child: Container(
        height: 50,
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
          AppLocalizations.of(context)!.signUp,
        ),
      ),
    );
  }
}

class _DepugSign extends StatelessWidget {
  const _DepugSign({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        50,
      ),
      onTap: () {
        navigateToWithReplacement(context, const HomeScreen());
      },
      child: Container(
        height: 40,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(
              50,
            )),
        child: Text(
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            "debug sign"),
      ),
    );
  }
}

class _UserEmailFormFeild extends StatelessWidget {
  const _UserEmailFormFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // user email feild
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50,
          ),
          // boxShadow: AppConstants.theLightBoxShdow,
          border: AppConstants.customBorderOnePixel,
          color: Colors.white),
      child: FormBuilderTextField(
        name: AppLocalizations.of(context)!.email,
        keyboardType: TextInputType.emailAddress,

        style: _customLocalTextStyle,
        controller: signUpUserEmailTextEditingController,
        // validator: (value) {
        //  if ( value!.length < 4 ) {
        //   return
        //   "too short" ; }
        //   return null;
        // },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return null;
          } else if (value.length < 5) {
            return 'Please enter a valid email';
          }

          // if (value == null || value.isEmpty || value.length < 5) {
          //   return 'Please enter an email';
          // }
          // final emailPattern =
          //     RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
          // if (!emailPattern.hasMatch(value)) {
          //   return 'Please enter a valid email address';
          // }
          ///
          ///
          ///
          ///
          // const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          //     r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          //     r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          //     r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          //     r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          //     r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          //     r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
          // final regex = RegExp(pattern);
          // if (value.isNotEmpty && !regex.hasMatch(value)) {
          //   return 'Enter a valid email address';
          //   // : null;
          // }

          return null;
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.email,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // color: AppColors.greyColor,
                height: .8,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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

class _UserPhonNumText extends StatelessWidget {
  const _UserPhonNumText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // user phoneNum feild
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50,
          ),
          // boxShadow: AppConstants.theLightBoxShdow,
          border: AppConstants.customBorderOnePixel,
          color: Colors.white),
      child: FormBuilderTextField(
        name: AppLocalizations.of(context)!.phoneNum,
        keyboardType: TextInputType.phone,

        style: _customLocalTextStyle,
        controller: signUpUserPhonNumTextEditingController,
        // #### fully working validator #### //
        // #### #### //
        validator: (value) {
          final phoneExp = RegExp(r'^\+?1?\d{9,15}$');
          // print("vvvvvvvvvvvvvvvvvvvvvvvv${value.runtimeType}");
          if (value == null || value.isEmpty) {
            return 'Please enter a phone number';
          }

          if (value.length < 9) {
            return 'Password must be at least 9 characters long';
          }

          if (!phoneExp.hasMatch(value)) {
            return 'Please enter a trueee phone number';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.phoneNum,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // color: AppColors.greyColor,
                height: .8,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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

class _UserNameArbFormFeild extends StatelessWidget {
  const _UserNameArbFormFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // user name feild
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50,
          ),
          // boxShadow: AppConstants.theLightBoxShdow,
          border: AppConstants.customBorderOnePixel,
          color: Colors.white),
      child: FormBuilderTextField(
        name: AppLocalizations.of(context)!.full_arabic_name,
        keyboardType: TextInputType.name,
        style: _customLocalTextStyle,
        controller: signUPArbUserNameTextEditingContorller,

        // #### fully working validator #### //
        // #### #### //
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid name';
          }

          if (value.length < 3) {
            return 'the name must be at least 3 characters long';
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.full_arabic_name,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // color: AppColors.greyColor,
                height: .8,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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

class _UserNameEngFormFeild extends StatelessWidget {
  const _UserNameEngFormFeild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // user name feild
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50,
          ),
          // boxShadow: AppConstants.theLightBoxShdow,
          border: AppConstants.customBorderOnePixel,
          color: Colors.white),
      child: FormBuilderTextField(
        name: AppLocalizations.of(context)!.full_english_name,
        keyboardType: TextInputType.name,
        style: _customLocalTextStyle,
        controller: signUPEngUserNameTextEditingContorller,

        // #### fully working validator #### //
        // #### #### //
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid name';
          }

          if (value.length < 3) {
            return 'the name must be at least 3 characters long';
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.full_english_name,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                // color: AppColors.greyColor,
                height: .8,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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
