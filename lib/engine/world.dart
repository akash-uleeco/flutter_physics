import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/objects/ball.dart';

class World {
  List<PhysicsObject> things = [];

  World() {
    things.add(Ball(100, 100, 50));
    // things.add(Line(100, 100, 50));
  }

  void update(Size size) {
    things.forEach((element) {
      (element as Ball).update(size);
    });
  }

  void render(Canvas canvas) {
    things.forEach((element) {
      element.render(canvas);
    });
  }
}

abstract class PhysicsObject {
  double x, y, vx, vy;

  PhysicsObject(this.x, this.y, {this.vx = 0, this.vy = 0});

  void applyGravity() {
    y++;
  }

  void updateInternal(Size size);

  void update(Size size) {
    updateInternal(size);
    x = x + vx;
    y = y + vy;
    applyGravity();
  }

  void render(Canvas canvas);
}
