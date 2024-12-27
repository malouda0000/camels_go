import 'package:camels_go/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TitleBackwordWidget extends StatelessWidget {
  const TitleBackwordWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Container(
            width: 23,
            height: 23,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 15,
            ),
          ),
          Text(title,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
