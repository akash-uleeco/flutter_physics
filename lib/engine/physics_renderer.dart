import 'package:flutter/material.dart';

class PhysicsRenderer extends StatelessWidget {
  const PhysicsRenderer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PhysicsPainter(),
    );
  }
}

class PhysicsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.red, BlendMode.color);
    canvas.drawCircle(const Offset(50, 55), 40, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
