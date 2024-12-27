// ignore_for_file: prefer_const_constructors

import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/constants/app_images.dart';
import 'package:camels_go/core/func/nav_func.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:camels_go/main.dart';
import 'package:camels_go/view/dash_board/dash_board.dart';
import 'package:camels_go/view/home/bloc/vendro_bloc/bloc/vendor_bloc.dart';
import 'package:camels_go/view/home/bloc/vendro_bloc/bloc/vendor_event.dart';
import 'package:camels_go/view/home/bloc/vendro_bloc/bloc/vendor_state.dart';
import 'package:camels_go/view/home/widgets/drawer/drawer.dart';
import 'package:camels_go/view/order_follow/order_follow.dart';
import 'package:camels_go/view/payments/payments.dart';
import 'package:camels_go/view/personal%20profile/bloc/personal_profile_bloc.dart';
import 'package:camels_go/view/purchase_services/bloc/purchase_services_bloc.dart';
import 'package:camels_go/view/purchase_services/purchase_services.dart';
import 'package:camels_go/view/settings/settings_screen.dart';
import 'package:camels_go/view/shared/screens/loading_screen.dart';
import 'package:camels_go/view/shared/screens/under_deve_screen.dart';
import 'package:camels_go/view/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<PersonalProfileBloc>().add(GetPersonalProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black, // Your desired app bar color

      appBar: AppBar(
        backgroundColor: AppColors.mainColor, // Your desired app bar color
        elevation: 0, // Remove shadow if desired
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu_rounded,
                color: Theme.of(context).appBarTheme.iconTheme!.color,
              ),
            );
          },
        ),

        centerTitle: true,
        title: Image.asset(AppImages.logoDarkAll),

        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, UnderDevScreen());
            },
            icon: Icon(
              Icons.notifications_on_rounded,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            ),
          ),
          IconButton(
            onPressed: () {
              navigateTo(context, SettingsScreen());
            },
            icon: Icon(
              Icons.settings_rounded,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _CustomSliverAppBar(),
              AppConstants.emptySpaceTenPixl,
              AppConstants.emptySpaceTenPixl,

              // #### the daynamic add #### //
              // #### the daynamic add #### //
              // #### the daynamic add #### //

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: AppConstants.theNewBorderRadiusTenPX,
                    // color: AppColors.greyColor.withOpacity(.6),
                    color: AppColors.silverColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image: AssetImage(
                          //     AppImages.store,
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),

                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10,
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              AppLocalizations.of(context)!.new_year_message +
                                  AppLocalizations.of(context)!
                                      .new_year_message +
                                  AppLocalizations.of(context)!
                                      .new_year_message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: AppColors.darkGreyColor,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              AppConstants.emptySpaceTenPixl,
              AppConstants.emptySpaceTenPixl,

              // #### the body #### //
              // #### the body #### //
              // #### the body #### //
              Padding(
                padding: const EdgeInsets.all(
                    15.0), // Add padding around the GridView
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15, // Spacing between columns
                    mainAxisSpacing: 15, // Spacing between rows
                  ),
                  children: [
                    HomeWidget(
                      // isActive: false,
                      imageName: AppImages.list,
                      widgetName: AppLocalizations.of(context)!.total_orders,
                      onTap: () {
                        navigateTo(context, DashboardScreen());
                        // navigateTo(context, widget)
                      },
                    ),
                    HomeWidget(
                      // isActive: true,
                      imageName: AppImages.cash,
                      widgetName: AppLocalizations.of(context)!.total_amounts,
                      onTap: () {
                        navigateTo(context, PaymentsScreen());
                      },
                    ),
                    HomeWidget(
                      // isActive: false,
                      imageName: AppImages.store,
                      widgetName: AppLocalizations.of(context)!.total_stock,
                      onTap: () {
                        navigateTo(context, StoreScreen());
                      },
                    ),
                    HomeWidget(
                      // isActive: false,
                      imageName: AppImages.laptop,
                      widgetName: AppLocalizations.of(context)!.track_orders,
                      onTap: () {
                        navigateTo(context, OrderFollowScreen());
                      },
                    ),
                    HomeWidget(
                      // isActive: false,
                      imageName: AppImages.person,
                      widgetName:
                          AppLocalizations.of(context)!.request_collection,
                      onTap: () {
                        navigateTo(context, PurchaseServicesScreen());
                      },
                    ),
                    HomeWidget(
                      // isActive: false,
                      imageName: AppImages.services,
                      widgetName: AppLocalizations.of(context)!.buy_services,
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              title: Text(AppLocalizations.of(context)!
                                  .confirm_request),
                              content: Text(AppLocalizations.of(context)!
                                  .confirm_delivery_request),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<PurchaseServicesBloc>()
                                        .add(MakeRequestEvent(
                                          companyId: 867,
                                          serviceId: 1,
                                        ));
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                        AppLocalizations.of(context)!.confirm,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white)),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        // navigateTo(context, widget)
                      },
                    ),
                  ],
                ),
              ),

              AppConstants.emptySpaceFifteenPixl,
              AppConstants.emptySpaceFifteenPixl,
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        // boxShadow: AppConstants.theBoxShdow,

        color: AppColors.mainColor,
      ),
      child: Column(
        children: [
          Spacer(),
          BlocBuilder<VendorBloc, VendorState>(
            builder: (context, state) {
              return Container(
                // title and email header
                height: 50,
                width: double.infinity,
                // color: Colors.amber,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<VendorBloc>()
                            .add(FetchVendorCompaniesEvent());
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 5),
                              child: SingleChildScrollView(
                                child: BlocBuilder<VendorBloc, VendorState>(
                                  builder: (context, state) {
                                    if (state is VendorInitialState) {
                                      return Center(
                                        child: SizedBox(
                                            height: 250,
                                            width: double.infinity,
                                            child: CustomLoadingScreen()),
                                      );
                                    }

                                    if (state is VendorLoadingState) {
                                      return Center(
                                        child: SizedBox(
                                            height: 250,
                                            width: double.infinity,
                                            child: CustomLoadingScreen()),
                                      );
                                    }

                                    if (state is VendorErrorState) {
                                      return Center(
                                        child: SizedBox(
                                            height: 250,
                                            width: double.infinity,
                                            child: Text(state.message)),
                                      );
                                    }

                                    if (state is VendorCompaniesLoadedState) {
                                      return Column(
                                        children: [
                                          // _CompanyListTile(),
                                          // _CompanyListTile(),
                                          // _CompanyListTile(),

                                          for (int i = 0;
                                              i < state.companies.length;
                                              i++)
                                            _CompanyListTile(
                                              companyNameAr:
                                                  state.companies[i].nameAr,
                                              companyNameEn:
                                                  state.companies[i].nameEn,
                                              logoUrl: state.companies[i].logo,
                                              notificationCount: state
                                                  .companies[i]
                                                  .notificationsCount,
                                              isActive: true,
                                            ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          color: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                          // onClosing: () {},
                        );
                      },
                      child: BlocBuilder<PersonalProfileBloc,
                          PersonalProfileState>(
                        builder: (context, state) {
                          return Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.darkBgColor, width: 2),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  (globalCachedUserImage == null ||
                                          globalCachedUserImage == "")
                                      ? globalCachedUserImageUserDoesntExiset!
                                      : globalCachedUserImage!,
                                  // globalCachedUserImageUserDoesntExiset!
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      ///
                      ///
                      ///
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          children: [
                            BlocBuilder<PersonalProfileBloc,
                                PersonalProfileState>(
                              builder: (context, state) {
                                return Expanded(
                                  // the title and bank account
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // #### user name #### //
                                      if (Localizations.localeOf(context)
                                              .languageCode ==
                                          "ar")
                                        Text(
                                          ((globalCachedArabicUserName ==
                                                      null ||
                                                  globalCachedArabicUserName ==
                                                      "")
                                              ? AppLocalizations.of(context)!
                                                  .userName
                                              : globalCachedArabicUserName!),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .titleTextStyle!
                                                .color,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      if (Localizations.localeOf(context)
                                              .languageCode ==
                                          "en")
                                        Text(
                                          ((globalCachedEnglishUserName ==
                                                      null ||
                                                  globalCachedEnglishUserName ==
                                                      "")
                                              ? AppLocalizations.of(context)!
                                                  .userName
                                              : globalCachedEnglishUserName!),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .titleTextStyle!
                                                .color,
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                      ///
                                      ///
                                      ///
                                      ///
                                      // Text(
                                      //   "email",
                                      //   style: TextStyle(
                                      //       // fontWeight: FontWeight.bold,
                                      //       // fontSize: 16,
                                      //       ),
                                      // ),

                                      // #### user email #### //
                                      Text(
                                        ((globalCachedUserEmail == null ||
                                                globalCachedUserEmail == "")
                                            ? AppLocalizations.of(context)!
                                                .userEmail
                                            : globalCachedUserEmail!),
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .titleTextStyle!
                                              .color,
                                          fontSize: 12,
                                          // height: 0.8,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      ///
                                      ///
                                      ///
                                      ///
                                    ],
                                  ),
                                );
                              },
                            ),
                            Expanded(
                              // the date
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Expanded(
                                    child: _DateWidget(),
                                  ),
                                  // for small white space
                                  // Expanded(
                                  //   child: Text(
                                  //     "bank account" + "card number",
                                  //     style: TextStyle(
                                  //         // fontWeight: FontWeight.bold,
                                  //         // fontSize: 16,
                                  //         ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// class _CompanyListTile extends StatelessWidget {
//   final String? companyNameAr;
//   final String? companyNameEn;
//   final String? logoUrl;
//   final int? notificationCount;
//   const _CompanyListTile({
//     super.key,
//     required this.companyNameAr,
//     required this.companyNameEn,
//     required this.logoUrl,
//     required this.notificationCount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: ListTile(
//         leading: Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//             border: Border.all(color: AppColors.darkBgColor, width: 2),
//           ),
//         ),
//         title: Text(
//           "company name",
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,

//                 // color: Theme.of(context)
//                 //     .appBarTheme
//                 //     .titleTextStyle!
//                 //     .color,
//               ),
//         ),
//         subtitle: Text(
//           "notifications number: 5",
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//               fontSize: 13,
//               color: Theme.of(context).brightness == Brightness.dark
//                   ? Colors.white
//                   : Theme.of(context).textTheme.bodyMedium!.color),
//         ),
//         trailing: Container(
//           height: 18,
//           width: 18,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.blue,
//           ),
//           child: Icon(
//             Icons.check,
//             size: 15,
//             color: Theme.of(context).scaffoldBackgroundColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

class _CompanyListTile extends StatelessWidget {
  final String? companyNameAr;
  final String? companyNameEn;
  final String? logoUrl;
  final int? notificationCount;
  final bool? isActive; // Determines the visibility of trailing

  const _CompanyListTile({
    super.key,
    required this.companyNameAr,
    required this.companyNameEn,
    required this.logoUrl,
    required this.notificationCount,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the localized company name based on the locale
    final locale = Localizations.localeOf(context).languageCode;
    final companyName = locale == 'ar' ? companyNameAr : companyNameEn;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            image: logoUrl != null
                ? DecorationImage(
                    image: NetworkImage(logoUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: logoUrl == null
              ? Icon(Icons.image_not_supported, color: Colors.grey)
              : null,
        ),
        title: Text(
          companyName ?? "N/A", // Fallback to "N/A" if name is null
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
        ),
        subtitle: Text(
          "Notifications: ${notificationCount ?? 0}", // Fallback to 0 if null
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium!.color,
              ),
        ),
        trailing: isActive == true
            ? Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.check,
                  size: 15,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              )
            : null, // No trailing widget if isActive is false
      ),
    );
  }
}

// class _CompanyListTile extends StatelessWidget {
//   final String? companyNameAr;
//   final String? companyNameEn;
//   final String? logoUrl;
//   final int? notificationCount;
//   const _CompanyListTile({
//     super.key,
//     required this.companyNameAr,
//     required this.companyNameEn,
//     required this.logoUrl,
//     required this.notificationCount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: ListTile(
//         leading: Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//             border: Border.all(color: AppColors.darkBgColor, width: 2),
//           ),
//         ),
//         title: Text(
//           "company name",
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,

//                 // color: Theme.of(context)
//                 //     .appBarTheme
//                 //     .titleTextStyle!
//                 //     .color,
//               ),
//         ),
//         subtitle: Text(
//           "notifications number: 5",
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//               fontSize: 13,
//               color: Theme.of(context).brightness == Brightness.dark
//                   ? Colors.white
//                   : Theme.of(context).textTheme.bodyMedium!.color),
//         ),
//         trailing: Container(
//           height: 18,
//           width: 18,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.blue,
//           ),
//           child: Icon(
//             Icons.check,
//             size: 15,
//             color: Theme.of(context).scaffoldBackgroundColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
class _DateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

    // Format the day of the week and the date based on the locale
    String dayOfWeek =
        DateFormat('EEEE', Localizations.localeOf(context).languageCode)
            .format(now);
    String formattedDate =
        DateFormat('dd/MM/yyyy', Localizations.localeOf(context).languageCode)
            .format(now);

    return Expanded(
      child: Text(
        '${AppLocalizations.of(context)!.date} :$dayOfWeek\n $formattedDate', // Add a line break after 'Date:'
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Theme.of(context).appBarTheme.titleTextStyle!.color,
        ),
        maxLines: 2, // Ensure only two lines are displayed
        overflow: TextOverflow.ellipsis, // Truncate with ellipsis if overflow
        textAlign:
            TextAlign.start, // Align text to start (works for both LTR and RTL)
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  final bool? isActive;
  final String? imageName, widgetName;
  final void Function()? onTap;

  HomeWidget({
    super.key,
    this.isActive,
    this.imageName,
    this.widgetName,
    this.onTap,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onTapDown: (_) {
        // Called when the user starts touching
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        // Called when the user lifts their finger
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        // Called when the touch is canceled (e.g., finger dragged off widget)
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppConstants.theNewBorderRadiusTenPX,
          boxShadow: AppConstants.theBoxShdow,
          color: isPressed
              ? AppColors
                  .darkBgColor // Gray color while the widget is being pressed
              : widget.isActive == true
                  ? AppColors.darkBgColor
                  : Colors.white, // Default colors based on isActive
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imageName!,
              width: 100,
              height: 100,
            ),
            AppConstants.emptySpaceTenPixl,
            AppConstants.emptySpaceTenPixl,
            Text(
              widget.widgetName ?? "the name",
              style: TextStyle(
                color: widget.isActive == true ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
