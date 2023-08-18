import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/world.dart';

class PhysicsRenderer extends StatefulWidget {
  const PhysicsRenderer({Key? key}) : super(key: key);

  @override
  State<PhysicsRenderer> createState() => _PhysicsRendererState();
}

class _PhysicsRendererState extends State<PhysicsRenderer> with SingleTickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PhysicsPainter(),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class PhysicsPainter extends CustomPainter {
  final world = World();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.red, BlendMode.color);
    world.render(canvas, size);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
