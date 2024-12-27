import 'package:flutter/material.dart';

class VerticalDottedLinePainter extends CustomPainter {
  final Color color;

  VerticalDottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    double dashHeight = 5, dashSpace = 3;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class VerticalDottedLine extends StatelessWidget {
  final double height;
  final Color color;

  const VerticalDottedLine({Key? key, required this.height, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1, height), // Width is fixed for vertical lines
      painter: VerticalDottedLinePainter(color: color),
    );
  }
}