import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/world.dart';

class Ball extends PhysicsObject {
  double r;
  Ball(double x, double y, this.r) : super(x, y);

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(x, y), r, Paint()..color = Colors.white);
  }

  @override
  void updateInternal(Size size) {
    super.vx = 0;
    super.vy =10;
  }

}


