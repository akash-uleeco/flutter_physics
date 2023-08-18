import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/world.dart';
import 'dart:math';

class Ball extends PhysicsObject {
  double r;
  Paint? pOutline, pFill;

  Ball(double x, double y, this.r, {double vx = 0, double vy = 0})
      : super(x, y, vx: vx, vy: vy) {
    pOutline = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    pFill = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(x, y), r, pFill!);
    canvas.drawCircle(Offset(x, y), r, pOutline!);
  }

  @override
  void updateInternal(Size size) {}

  @override
  double distance(PhysicsObject other) {
    if (other is Ball) {
      var t1 = pow((x - other.x), 2);
      var t2 = pow((y - other.y), 2);
      var d = sqrt(t1 + t2);
      return d;
    }
    return -1;
  }
}
