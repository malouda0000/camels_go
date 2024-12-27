import 'package:camels_go/core/constants/app_constants.dart';
import 'package:camels_go/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? hintText;
  final bool? isPassword, shadow;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final double? borderRaduis;
  final void Function(String)? onFieldSubmitted;
  final Color? borderColor;
  const AppTextFormField({
    Key? key,
    required this.onChanged,
    this.isPassword,
    this.shadow,
    required this.validator,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.borderRaduis,
    this.onFieldSubmitted,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          borderRaduis ?? 15,
        ),
        color: Colors.white,
        boxShadow: shadow == true
            ?
            AppConstants.theLightBoxShdow
            : null,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: const TextStyle(
          decoration: TextDecoration.none,
          decorationThickness: 0,
        ),
        cursorColor: AppColors.mainColor,
        obscureText: isPassword ?? false,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
            borderSide: const BorderSide(color: AppColors.redColor),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.greyColor,
          ),
          errorStyle: const TextStyle(
            color: AppColors.redColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
