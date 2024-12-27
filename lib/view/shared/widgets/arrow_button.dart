import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final Color color;
  final double? size;
  final Color? iconColor;

  const ArrowButton({
    required this.onPressed,
    this.icon,
    required this.color,
    this.size,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 23,
        height: 23,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon ?? Icons.arrow_forward_ios,
            color: iconColor ?? Colors.white, size: size),
      ),
    );
  }
}
