import 'package:camels_go/core/constants/app_images.dart';
import 'package:flutter/material.dart';

class AuthCustomIcon extends StatelessWidget {
  const AuthCustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(
        AppImages.logoLight,
      ),
      height: 40, // Set the height
      width: 180, // Set the width
      fit: BoxFit
          .contain, // Ensures the image scales to fit within the dimensions
    );
  }
}
