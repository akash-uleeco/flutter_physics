import 'package:flutter/material.dart';

class World {
  List<Thing> things = [];


  World() {
    things.add(Ball(100, 100, 50));
  }

  void render(Canvas canvas, Size size) {
    things.forEach((element) {
      element.render(canvas, size);
      (element as Ball).applyGravity();
    });
  }
}

class Ball extends Thing {
  double x, y, r;

  Ball(this.x, this.y, this.r);

  @override
  void render(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(x, y), r, Paint()..color = Colors.white);
  }

  void applyGravity() {
    y = y+1;
  }
}

abstract class Thing {
  void render(Canvas canvas, Size size);
}
