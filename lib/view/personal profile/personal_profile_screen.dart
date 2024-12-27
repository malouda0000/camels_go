import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/constants/app_images.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/main.dart';
import 'package:camels_go/view/personal%20profile/bloc/personal_profile_bloc.dart';
import 'package:camels_go/view/shared/screens/error_screen.dart';
import 'package:camels_go/view/shared/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const bool isEnabeld = false;
final TextEditingController arabicNameEditingController =
    TextEditingController();
final TextEditingController englishNameEditingController =
    TextEditingController();
final TextEditingController nationaltyArEditingController =
    TextEditingController();
final TextEditingController nationaltyEnEditingController =
    TextEditingController();
final TextEditingController birthDateEditingController =
    TextEditingController();
final TextEditingController userEmailEditingController =
    TextEditingController();
final TextEditingController userPhoneEditingController =
    TextEditingController();

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({super.key});

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // name
    // arabicNameEditingController.text = globalCachedArabicUserName ??
    //     AppLocalizations.of(context)!.full_arabic_name;

    // // name english
    // englishNameEditingController.text =
    //     globalCachedEnglishUserName ?? AppLocalizations.of(context)!.userName;

    // // nationalty
    // nationaltyArEditingController.text =
    //     globalCachedNationaltyAr ?? AppLocalizations.of(context)!.nationality;

    // // nationalty
    // nationaltyEnEditingController.text =
    //     globalCachedNationaltyEn ?? AppLocalizations.of(context)!.nationality;

    // // birthdate
    // birthDateEditingController.text =
    //     globalCachedUserBirthdate ?? AppLocalizations.of(context)!.birth_date;

    // // gender
    // // arabicNameEditingController.text = globalCachedArabicUserName ??
    // //     AppLocalizations.of(context)!.full_arabic_name;

    // // email
    // userEmailEditingController.text =
    //     globalCachedUserEmail ?? AppLocalizations.of(context)!.email;

    // // phone number
    // userPhoneEditingController.text =
    //     globalCachedUserPhoneNum ?? AppLocalizations.of(context)!.phoneNum;

    // Initialize controllers with default or cached values (without `context`)
    arabicNameEditingController.text = globalCachedArabicUserName ?? '';
    englishNameEditingController.text = globalCachedEnglishUserName ?? '';
    nationaltyArEditingController.text = globalCachedNationaltyAr ?? '';
    nationaltyEnEditingController.text = globalCachedNationaltyEn ?? '';
    birthDateEditingController.text = globalCachedUserBirthdate ?? '';
    userEmailEditingController.text = globalCachedUserEmail ?? '';
    userPhoneEditingController.text = globalCachedUserPhoneNum ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Use `AppLocalizations.of(context)` safely here
    arabicNameEditingController.text =
        arabicNameEditingController.text.isNotEmpty
            ? arabicNameEditingController.text
            : AppLocalizations.of(context)!.full_arabic_name;

    englishNameEditingController.text =
        englishNameEditingController.text.isNotEmpty
            ? englishNameEditingController.text
            : AppLocalizations.of(context)!.userName;

    nationaltyArEditingController.text =
        nationaltyArEditingController.text.isNotEmpty
            ? nationaltyArEditingController.text
            : AppLocalizations.of(context)!.nationality;

    nationaltyEnEditingController.text =
        nationaltyEnEditingController.text.isNotEmpty
            ? nationaltyEnEditingController.text
            : AppLocalizations.of(context)!.nationality;

    birthDateEditingController.text = birthDateEditingController.text.isNotEmpty
        ? birthDateEditingController.text
        : AppLocalizations.of(context)!.birth_date;

    userEmailEditingController.text = userEmailEditingController.text.isNotEmpty
        ? userEmailEditingController.text
        : AppLocalizations.of(context)!.email;

    userPhoneEditingController.text = userPhoneEditingController.text.isNotEmpty
        ? userPhoneEditingController.text
        : AppLocalizations.of(context)!.phoneNum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      //   centerTitle: true,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).canPop() == true
      //           ? Navigator.of(context).pop()
      //           : null;
      //     },
      //     icon: Container(
      //       height: 24,
      //       width: 24,
      //       padding: EdgeInsets.all(1),
      //       decoration: BoxDecoration(
      //         color: AppColors.mainColor,
      //         borderRadius: BorderRadius.circular(5),
      //       ),
      //       alignment: Alignment.center,
      //       child: Icon(
      //         Icons.arrow_back_ios,
      //         size: 16,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      //   title: Text(
      //     AppLocalizations.of(context)!.personalPage,
      //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      //   ),
      // ),
      body: SafeArea(
        child: BlocBuilder<PersonalProfileBloc, PersonalProfileState>(
          builder: (context, state) {
            //  if (state is AuthLoadingStateSignIn) {
            //   return Center(
            //     child: const SizedBox(
            //         width: 300,
            //         height: 700,
            //         child: CustomLoadingScreen()),
            //   );}
            if (state is PersonalProfileErrorState) {
              return Center(
                child: SizedBox(
                    width: 300,
                    height: 700,
                    child: ErrorScreen(errorMessage: state.errorMessage)),
              );
            }

            // else if (state is AuthInitialState )
            // {return CustomLoadingScreen();}

            // else if (state is AuthSuccessState )
            // {return _LoginBody();}

            else if (state is PersonalProfileSuccessState) {
              return ListView(
                // padding: EdgeInsets.symmetric(horizontal: 15),
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(AppImages.coverPng),
                          fit: BoxFit.cover,
                        )),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 200,
                            width: double.infinity,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: AppColors.darkGreyColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.mainColor, width: 2),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          (globalCachedUserImage == null ||
                                                  globalCachedUserImage == "")
                                              ? globalCachedUserImageUserDoesntExiset!
                                              : globalCachedUserImage!,
                                          // globalCachedUserImageUserDoesntExiset!
                                        ),
                                        fit: BoxFit.cover),
                                    boxShadow: AppConstants.theBoxShdow,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.personal_image,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).canPop() == true
                                  ? Navigator.of(context).pop()
                                  : null;
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,

                        // user name arabic
                        _CustomTitle(
                          title: AppLocalizations.of(context)!.full_arabic_name,
                        ),
                        AppConstants.emptySpaceFifteenPixl,
                        _InfoShowFeild(
                          tilte: arabicNameEditingController.text ??
                              AppLocalizations.of(context)!.full_arabic_name,
                          validator: (value) {
                            return null;
                          },
                          enabled: isEnabeld,
                          textEditingController: arabicNameEditingController,
                        ),
                        AppConstants.emptySpaceFifteenPixl,

                        // #### #### //
                        // user name english
                        _CustomTitle(
                          title:
                              AppLocalizations.of(context)!.full_english_name,
                        ),
                        AppConstants.emptySpaceFifteenPixl,
                        _InfoShowFeild(
                          tilte: englishNameEditingController.text ??
                              AppLocalizations.of(context)!.full_english_name,
                          validator: (value) {
                            return null;
                          },
                          enabled: isEnabeld,
                          textEditingController: englishNameEditingController,
                        ),
                        AppConstants.emptySpaceFifteenPixl,

                        // // #### #### //
                        // // bairth date
                        SizedBox(
                          height: 75,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // user nationalty
                                    _CustomTitle(
                                      title: AppLocalizations.of(context)!
                                          .nationality,
                                    ),
                                    AppConstants.emptySpaceFifteenPixl,
                                    _InfoShowFeild(
                                      tilte: Localizations.localeOf(context)
                                                  .languageCode ==
                                              "ar"
                                          // ? (globalCachedNationaltyAr ?? "")
                                          // : (globalCachedNationaltyEn ?? ""),

                                          ? (nationaltyArEditingController
                                                  .text ??
                                              AppLocalizations.of(context)!
                                                  .nationality)
                                          : (nationaltyEnEditingController
                                                  .text ??
                                              AppLocalizations.of(context)!
                                                  .nationality),
                                      validator: (value) {
                                        return null;
                                      },
                                      enabled: isEnabeld,
                                      textEditingController:
                                          Localizations.localeOf(context)
                                                      .languageCode ==
                                                  "ar"
                                              ? nationaltyArEditingController
                                              : nationaltyEnEditingController,
                                    ),
                                    // AppConstants.emptySpaceFifteenPixl,
                                  ],
                                ),
                              ),
                              AppConstants.emptySpaceFifteenPixl,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // user name arabic
                                    _CustomTitle(
                                      title: AppLocalizations.of(context)!
                                          .birth_date,
                                    ),
                                    AppConstants.emptySpaceFifteenPixl,
                                    _InfoShowFeild(
                                      // tilte: globalCachedUserBirthdate ??
                                      //     AppLocalizations.of(context)!
                                      //         .birth_date,

                                      tilte: birthDateEditingController.text ??
                                          AppLocalizations.of(context)!
                                              .birth_date,
                                      validator: (value) {
                                        return null;
                                      },
                                      enabled: isEnabeld,
                                      textEditingController:
                                          birthDateEditingController,
                                    ),
                                    // AppConstants.emptySpaceFifteenPixl,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        AppConstants.emptySpaceFifteenPixl,

                        // #### #### //
                        // Gender
                        _CustomTitle(
                          title: AppLocalizations.of(context)!.gender,
                        ),
                        AppConstants.emptySpaceFifteenPixl,
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 180, // This width will now be respected
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(color: Colors.black),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 1)),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        height: double
                                            .infinity, // Ensures full height
                                        color: globalCachedUserGender == 1
                                            ? AppColors.mainColor
                                            : Theme.of(context)
                                                .scaffoldBackgroundColor, // Sets yell// Sets yellow background
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mail,
                                              size: 24,
                                            ),
                                            AppConstants.emptySpaceTenPixl,
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .male,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: double.infinity,
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        height: double
                                            .infinity, // Ensures full height
                                        color: globalCachedUserGender == 2
                                            ? AppColors.mainColor
                                            : Theme.of(context)
                                                .scaffoldBackgroundColor, // Sets yellow background

                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mail,
                                              size: 24,
                                            ),
                                            AppConstants.emptySpaceTenPixl,
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .female,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,
                        // #### #### //
                        Text(
                          AppLocalizations.of(context)!.login_informations,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                        ),

                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,
                        // #### #### //
                        // user email
                        _CustomTitle(
                          title: AppLocalizations.of(context)!.email,
                        ),
                        AppConstants.emptySpaceFifteenPixl,
                        _InfoShowFeild(
                          // tilte: globalCachedUserEmail ??
                          //     AppLocalizations.of(context)!.email,

                          tilte: userEmailEditingController.text ??
                              AppLocalizations.of(context)!.email,
                          validator: (value) {
                            return null;
                          },
                          enabled: isEnabeld,
                          textEditingController: userEmailEditingController,
                        ),
                        AppConstants.emptySpaceFifteenPixl,

                        // #### #### //

                        // user phone number
                        _CustomTitle(
                          title: AppLocalizations.of(context)!.phone_number,
                        ),
                        AppConstants.emptySpaceFifteenPixl,
                        Container(
                          height: 40,
                          width: double.infinity,
                          // alignment: Alignment
                          //     .centerLeft, // Vertical alignment is already correct
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, offset: Offset(0, 1))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: double.infinity,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "+971",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                color: Colors.black,
                                indent: 7,
                                endIndent: 7,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      globalCachedUserPhoneNum ??
                                          AppLocalizations.of(context)!
                                              .phoneNum,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,

                        InkWell(
                          onTap: () {
                            // navigateTo(context, EditProfileScreen());
                            setState(() {
                              isEnabeld == false ? isEnabeld == true : true;
                              // emit(saveDataState);
                            });

                            // print(
                            //     "tttttttttttttttttttttttttttttttttt${arabicNameEditingController.text}");
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            // alignment: Alignment
                            //     .centerLeft, // Vertical alignment is already correct
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(3),
                              //  border: Border.all(color: Colors.black),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  !isEnabeld
                                      ? AppLocalizations.of(context)!
                                          .edit_profile_informations
                                      : AppLocalizations.of(context)!.save,
                                  // "edit profile info",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.edit_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ),

                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,
                        AppConstants.emptySpaceFifteenPixl,
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: const SizedBox(
                    width: 300, height: 700, child: CustomLoadingScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}

class _InfoShowFeild extends StatelessWidget {
  final String? tilte;
  final TextEditingController textEditingController;
  final bool? enabled;
  final String? Function(String?)? validator;
  const _InfoShowFeild({
    super.key,
    required this.tilte,
    required this.textEditingController,
    required this.enabled,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      // alignment: Alignment
      //     .centerLeft, // Vertical alignment is already correct
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.black),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, 1))]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 15,
          ),
          Expanded(
            // child: Text(
            //   tilte ?? "Name",
            //   // style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyMedium!
            //       .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            // ),

            ///
            ///
            ///
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

              enabled: enabled ?? false,

              validator: validator,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: tilte,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                border: InputBorder.none,
                contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: 15,
                ),
              ),
            ),

            ///
            ///
            ///
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}

class _CustomTitle extends StatelessWidget {
  final String? title;
  _CustomTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? AppLocalizations.of(context)!.specialLine,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}
