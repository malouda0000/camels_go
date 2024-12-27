import 'dart:convert';

import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/helpers/cache_helper.dart';
import 'package:camels_go/core/helpers/dio_helper.dart';
import 'package:camels_go/core/helpers/user_expernce_helper.dart';
import 'package:camels_go/main.dart';
import 'package:camels_go/view/Auth/login/login_screen.dart';
import 'package:camels_go/view/Auth/model/sign_in_model.dart';
import 'package:camels_go/view/Auth/model/sign_up_model.dart';
import 'package:camels_go/view/Auth/register/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_status/http_status.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? cashedArabicUserName;
  String? cashedEnglishUserName;
  String? cashedUserID;
  String? cashedUserEmail;
  String? cashedUserToken;
  String? cashedUserPhoneNum;
//
//
  _cashUserData({
    required String token,
    String? arabicUserName,
    String? englishUserName,
    String? userID,
    String? userPhoneNumber,
    String? userEmail,
  }) async {
    await CacheHelper.setData(key: AppConstants.cachedUserToken, value: token);
    await CacheHelper.setData(
        key: AppConstants.cachedArabicUserName, value: arabicUserName);
    await CacheHelper.setData(
        key: AppConstants.cachedEnglishUserName, value: englishUserName);

    await CacheHelper.setData(key: AppConstants.cachedUserID, value: userID);
    await CacheHelper.setData(
        key: AppConstants.cachedUserPhonNum, value: userPhoneNumber);
    await CacheHelper.setData(
        key: AppConstants.cachedUserEmail, value: userEmail ?? "");

    cashedArabicUserName = arabicUserName;
    cashedEnglishUserName = englishUserName;
    cashedUserID = userID;
    cashedUserEmail = userEmail ?? "";
    cashedUserToken = token;
    cashedUserPhoneNum = userPhoneNumber ?? "";

    globalCachedUserToken = token;
    // globalCachedUserLang = token;
    globalCachedArabicUserName = arabicUserName;
    globalCachedEnglishUserName = englishUserName;
    globalCachedUserID = userID;
    globalCachedUserPhoneNum = userPhoneNumber;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.length < 3) {
      return 'Name must be more than 2 charater';
    } else {
      return null;
    }
  }

  String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  customValidator(text) {
    if (text == null || text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    return null;
  }

  //   String? validatepassword(String? value) {
  //  if ( value != null ){

  //    if (value.isEmpty ) {
  //     return 'password cannot be empty';
  //   }
  //   if (value.length < 4) {
  //     return 'password must be longer than 4 digit';
  //   }
  //  }

  //  else {
  //     return 'password cannot be empty';

  //   }
  // }

  // String? validateEmail(String? value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = RegExp(pattern);

  //   if (value != null) {
  //     if (value.isEmpty) {
  //       return 'Email cannot be empty';
  //     }
  //     if (!regex.hasMatch(value)) {
  //       return 'Enter Valid Email';
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return 'Email cannot be empty';
  //   }
  // }

  AuthBloc() : super(AuthInitialState()) {
    on<AuthEvent>((event, emit) async {
      // #### log in #### //
      emit(AuthLoadingStateSignIn());

      if (event is AuthLogInEvent) {
        emit(AuthLoadingStateSignIn());

        // Check for internet connectivity
        bool isConnected = await InternetConnectionChecker().hasConnection;
        if (!isConnected) {
          UserExperinceHelper()
              .showNetorkCheckerDialog(theContext: event.theContext);
          emit(AuthErrorStateSignIn(errorMessage: "No Internet Connection"));
          return;
        }

        // Validate the form
        // if (!signInFormKey.currentState!.validate()) {
        //   // setState(() {
        //   //   _autoValidate = AutovalidateMode.always;
        //   // });

        //   emit(AuthErrorStateSignIn(errorMessage: "Invalid form inputs"));
        //   return;
        // }

        try {
          // Make the login request
          Response logInResponse = await DioHelper.login(
            email: signInUserEmailTextEditingController.text,
            password: signInPasswordTextEditingController.text,
          );
          if (logInResponse.statusCode == 200) {
            ///
            ///
            ///
            ///
            ///

            SignInModel signInModel = SignInModel.fromJson(logInResponse.data);

            if (signInModel.message == "Login successful") {
              final String tooooken = signInModel.accessToken.toString();
              // print("ttttttttttttttttttttttttttttttttttttttttttttt $tooooken");
              if (tooooken.isNotEmpty) {
                await _cashUserData(
                  token: tooooken,
                  arabicUserName: '',
                  englishUserName: '',
                  userID: '',
                  userEmail: '',
                  userPhoneNumber: '',
                );
                await DioHelper.init();

                emit(AuthSuccessStateSignIn());
              } else {
                emit(AuthErrorStateSignIn(
                    errorMessage: "Token not found in response"));
              }
            } else {
              emit(AuthErrorStateSignIn(
                  errorMessage: signInModel.message ?? "Unknown error"));
            }

            // emit(AuthSuccessStateSignIn());
          } else {
            // Handle unexpected HTTP status codes
            emit(AuthErrorStateSignIn(
              errorMessage: "Unexpected error: ${logInResponse.statusCode}",
            ));
          }

          ///
          ///
          ///
          ///
        } catch (e) {
          // Handle error response or exceptions
          if (e is DioException && e.response != null) {
            // Parse error response
            SignInErrorModel errorResponse =
                SignInErrorModel.fromJson(e.response!.data);

            emit(AuthErrorStateSignIn(
              errorMessage: errorResponse.message,
            ));
          } else {
            emit(AuthErrorStateSignIn(
              errorMessage: "An error occurred: ${e.toString()}",
            ));
          }
        }
      }

      // #### log in #### //

      ///
      ///
      ///
      ///

      if (event is AuthSignupEvet) {
        // Emit loading state
        emit(AuthLoadingStateSignUp());

        // Check for network
        bool result = await InternetConnectionChecker().hasConnection;

        if (!result) {
          // Emit network error state
          emit(AuthErrorStateSignUp(errorMessage: 'No Internet connection'));
          UserExperinceHelper()
              .showNetorkCheckerDialog(theContext: event.theContext);
          return;
        }

        // print(
        //     "nameeeeeeeeeeee ${signUPEngUserNameTextEditingContorller.text}");
        try {
          // Send the sign-up request
          Response signupResponse = await DioHelper.signUp(
            arabicName: signUPArbUserNameTextEditingContorller.text,
            englishName: signUPEngUserNameTextEditingContorller.text,
            email: signUpUserEmailTextEditingController.text,
            mobile: signUpUserPhonNumTextEditingController.text,
            password: signUpPasswordTextEditingController.text,
            passwordConfirmation: signUpconfirmPassTexEdiController.text,
          );

          if (signupResponse.statusCode == 200) {
            // Parse response
            SignUpModel signUpModel = SignUpModel.fromJson(signupResponse.data);

            // Cache the user data
            await _cashUserData(
              token: signUpModel.accessToken ?? '',
              arabicUserName: signUpModel.data?.name?.en ?? '',
              englishUserName: signUpModel.data?.name?.en ?? '',
              userID: signUpModel.data?.id.toString() ?? '',
              userEmail: signUpModel.data?.email ?? '',
              userPhoneNumber: signUpModel.data?.mobile ?? '',
            );
            await DioHelper.init();

            // Emit success state
            emit(AuthSuccessStateSignUp());
          } else if (signupResponse.statusCode == 422) {
            // Handle validation errors
            SignUpErrorModel errorResponse =
                SignUpErrorModel.fromJson(signupResponse.data);

            String errorMessage = errorResponse.errors?['email']?.first ??
                'The email has already been taken.';

            emit(AuthErrorStateSignUp(errorMessage: errorMessage));
          } else {
            // Handle other unexpected errors

            emit(AuthErrorStateSignUp(
                errorMessage: signupResponse.statusMessage ?? 'Unknown error'));
          }
        } catch (e) {
          // Handle exceptions
          emit(AuthErrorStateSignUp(errorMessage: 'Exception occurred: $e'));
        }
      }

// #### sign up #### //
    });
  }
}
