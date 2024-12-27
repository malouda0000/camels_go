import 'package:camels_go/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';

class BrandProfileScreen extends StatelessWidget {
  const BrandProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        
        centerTitle: true,
        leading: IconButton(
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
        title: Text(
          AppLocalizations.of(context)!.brand_profile,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          AppConstants.emptySpaceFifteenPixl,
          AppConstants.emptySpaceFifteenPixl,
          AppConstants.emptySpaceFifteenPixl,
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
                        color: AppColors.darkGreyColor,
                      ),
                      image: DecorationImage(
                          image: AssetImage(AppImages.person),
                          fit: BoxFit.cover)),
                ),
                Text(
                  AppLocalizations.of(context)!.brand_logo,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                )
              ],
            ),
          ),

          AppConstants.emptySpaceFifteenPixl,
          AppConstants.emptySpaceFifteenPixl,

          // brand name arabic
          _CustomTitle(
            title: AppLocalizations.of(context)!.arabic_brand_name,
          ),
          AppConstants.emptySpaceFifteenPixl,
          _InfoShowFeild(
            tilte: AppLocalizations.of(context)!.arabic_brand_name,
          ),
          AppConstants.emptySpaceFifteenPixl,

// #### #### //

          // brand name english
          _CustomTitle(
            title: AppLocalizations.of(context)!.english_brand_name,
          ),
          AppConstants.emptySpaceFifteenPixl,
          _InfoShowFeild(
            tilte: AppLocalizations.of(context)!.english_brand_name,
          ),
          AppConstants.emptySpaceFifteenPixl,

// #### #### //
// brand email
          // SizedBox(
          //   height: 75,
          //   width: double.infinity,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // brand name arabic
          //             _CustomTitle(
          //               title: AppLocalizations.of(context)!.are_you_sure,
          //             ),
          //             AppConstants.emptySpaceFifteenPixl,
          //             _InfoShowFeild(
          //               tilte: AppLocalizations.of(context)!.userName,
          //             ),
          //             // AppConstants.emptySpaceFifteenPixl,
          //           ],
          //         ),
          //       ),
          //       AppConstants.emptySpaceFifteenPixl,
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // brand name arabic
          //             _CustomTitle(
          //               title: AppLocalizations.of(context)!.are_you_sure,
          //             ),
          //             AppConstants.emptySpaceFifteenPixl,
          //             _InfoShowFeild(
          //               tilte: AppLocalizations.of(context)!.email,
          //             ),
          //             // AppConstants.emptySpaceFifteenPixl,
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // AppConstants.emptySpaceFifteenPixl,

          // #### #### //
          // the human type
          // _CustomTitle(
          //   title: AppLocalizations.of(context)!.userName,
          // ),
          // AppConstants.emptySpaceFifteenPixl,
          // SizedBox(
          //   height: 40,
          //   width: 150,
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 40,
          //         width: 150, // This width will now be respected
          //         decoration: BoxDecoration(
          //           color: Theme.of(context).scaffoldBackgroundColor,
          //           borderRadius: BorderRadius.circular(3),
          //           border: Border.all(color: Colors.black),
          //           boxShadow: [
          //             BoxShadow(color: Colors.grey, offset: Offset(0, 1)),
          //           ],
          //         ),
          //         child: Row(
          //           children: [
          //             Flexible(
          //               flex: 1,
          //               child: Container(
          //                 height: double.infinity, // Ensures full height
          //                 color: AppColors.mainColor, // Sets yellow background
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   children: [
          //                     Icon(
          //                       Icons.mail,
          //                       size: 24,
          //                     ),
          //                     Text(
          //                       AppLocalizations.of(context)!.email,
          //                       style: Theme.of(context).textTheme.bodyMedium,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               height: double.infinity,
          //               width: 1,
          //               color: Colors.black,
          //             ),
          //             Flexible(
          //               flex: 1,
          //               child: Container(
          //                 height: double.infinity, // Ensures full height
          //                 // color: AppColors.mainColor, // Sets yellow background

          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   children: [
          //                     Icon(
          //                       Icons.mail,
          //                       size: 24,
          //                     ),
          //                     Text(
          //                       AppLocalizations.of(context)!.email,
          //                       style: Theme.of(context).textTheme.bodyMedium,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // AppConstants.emptySpaceFifteenPixl,
          // AppConstants.emptySpaceFifteenPixl,
          // AppConstants.emptySpaceFifteenPixl,
// #### #### //
          // Text(
          //   "login informations",
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodyLarge!
          //       .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          // ),

          // AppConstants.emptySpaceFifteenPixl,
          // AppConstants.emptySpaceFifteenPixl,
          // AppConstants.emptySpaceFifteenPixl,
          // #### #### //
          // brand email
          _CustomTitle(
            title: AppLocalizations.of(context)!.email,
          ),
          AppConstants.emptySpaceFifteenPixl,
          _InfoShowFeild(
            tilte: AppLocalizations.of(context)!.email,
          ),
          AppConstants.emptySpaceFifteenPixl,

// #### #### //

          // brand phone number
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
                  BoxShadow(color: Colors.grey, offset: Offset(0, 1))
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
                        // "568797546",
                        AppLocalizations.of(context)!.phone_number,
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

// #### #### //

          // brand mobile number
          _CustomTitle(
            title: AppLocalizations.of(context)!.mobile_number,
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
                  BoxShadow(color: Colors.grey, offset: Offset(0, 1))
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
                        // "568797546",
                        AppLocalizations.of(context)!.mobile_number,
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

          // #### #### //
          // brand description
          _CustomTitle(
            title: AppLocalizations.of(context)!.description,
          ),

          Container(
            height: 65,
            width: double.infinity,
            // alignment: Alignment
            //     .centerLeft, // Vertical alignment is already correct
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(0, 1))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  // the brand description
                  child: SingleChildScrollView(
                    child: Text(
                      AppLocalizations.of(context)!
                          .integrated_delivery_and_technology_services,
                      // style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          AppConstants.emptySpaceFifteenPixl,

          // #### #### //
          // brand location
          _CustomTitle(
            title: AppLocalizations.of(context)!.brand_location,
          ),

          Container(
            height: 160,
            width: double.infinity,
            // alignment: Alignment
            //     .centerLeft, // Vertical alignment is already correct
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(color: Colors.grey, offset: Offset(0, 1))
                ]),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!
                    .integrated_delivery_and_technology_services,
                // style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),

// and this is what we will see for now giel

          AppConstants.emptySpaceFifteenPixl,
          AppConstants.emptySpaceFifteenPixl,
          AppConstants.emptySpaceFifteenPixl,
          AppConstants.emptySpaceFifteenPixl,

          InkWell(
            onTap: () {
              // navigateTo(context, EditBrandProfileScreen());
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
                    BoxShadow(color: Colors.grey, offset: Offset(0, 1))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.edit_brand_informations,
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
    );
  }
}

class _InfoShowFeild extends StatelessWidget {
  final String? tilte;
  const _InfoShowFeild({
    super.key,
    required this.tilte,
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
            child: Text(
              tilte ?? "Name",
              // style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ),
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
