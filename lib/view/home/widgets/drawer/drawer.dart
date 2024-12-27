import 'package:camels_go/main.dart';
import 'package:camels_go/view/home/widgets/drawer/drawer_header.dart';
import 'package:camels_go/view/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppConstants.emptySpaceTenPixl,
            // AppConstants.emptySpaceTenPixl,
            // AppConstants.emptySpaceTenPixl,
            // AppConstants.emptySpaceTenPixl,
            CustomDrawerHeader(
              // avatarUrl: 'https://example.com/avatar.jpg',
              avatarUrl: globalCachedUserImageUserDoesntExiset!,
              userName: AppLocalizations.of(context)!.userName,
              userEmail: AppLocalizations.of(context)!.userEmail,
              // backgroundImageUrl: 'https://example.com/background.jpg',
              // backgroundImageUrl:
              // "https://in.pinterest.com/pin/background--895583075878313712/",
              backgroundImageUrl:
                  "https://i.pinimg.com/736x/79/2e/11/792e1171dc7763d141c627e904c39b65.jpg",
            ),
            SettingsBody(), 
          ],
        ),
      ),
    );
  }
}
