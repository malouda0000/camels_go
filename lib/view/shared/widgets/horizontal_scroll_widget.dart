import 'package:flutter/material.dart';

class HorizontalScrollWidget extends StatelessWidget {
  const HorizontalScrollWidget({
    super.key,
    required this.content,
    required this.widthSize,
    this.padding,
  });

  final Widget content;
  final int widthSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: padding ?? const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * widthSize,
          child: content,
        ));
  }
}
