import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/world.dart';

class Ball extends PhysicsObject {
  double r;
  Ball(double x, double y, this.r, {double vx = 0, double vy = 0}) : super(x, y, vx: vx, vy: vy);

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(x, y), r, Paint()..color = Colors.white);
  }

  @override
  void updateInternal(Size size) {

  }

}