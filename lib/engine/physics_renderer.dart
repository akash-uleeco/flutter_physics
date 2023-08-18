import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/world.dart';

class PhysicsRenderer extends StatefulWidget {
  const PhysicsRenderer({Key? key}) : super(key: key);

  @override
  State<PhysicsRenderer> createState() => _PhysicsRendererState();
}

class _PhysicsRendererState extends State<PhysicsRenderer>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  World world = World();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PhysicsPainter(world),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    controller!.addListener(() {
      setState(() {});
    });
    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller!.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller!.forward();
      }
    });

    controller!.forward();
  }
}

class PhysicsPainter extends CustomPainter {
  final World world;

  PhysicsPainter(this.world);

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
