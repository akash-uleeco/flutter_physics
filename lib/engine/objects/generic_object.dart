

import 'dart:ui';

import 'package:flutter/material.dart';

import '../world.dart';

class GenericObject extends PhysicsObject {
  double r;
  GenericObject(double x, double y, this.r, {double vx = 0, double vy = 0}) : super(x, y, vx: vx, vy: vy);

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(x, y), r, Paint()..color = Colors.yellow);
  }

  @override
  void updateInternal(Size size) {

  }

}