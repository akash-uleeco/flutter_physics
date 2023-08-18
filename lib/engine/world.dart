import 'package:flutter/material.dart';

class World {
  List<Thing> things = [];

  World() {
    things.add(Ball(100, 100, 50));
  }

  void render(Canvas canvas, Size size) {
    things.forEach((element) {
      (element as Ball).applyGravity();
      element.render(canvas, size);
    });
  }
}

class Ball extends Thing {
  double x, y, r;

  Ball(this.x, this.y, this.r);

  @override
  void render(Canvas canvas, Size size) {
    print(y);
    canvas.drawCircle(Offset(x, y), r, Paint()..color = Colors.white);
  }

  void applyGravity() {
    y++;
  }
}

abstract class Thing {
  void render(Canvas canvas, Size size);
}
