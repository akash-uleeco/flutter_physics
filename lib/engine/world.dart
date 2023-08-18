import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/objects/ball.dart';

class World {
  static const G = 1.0;
  static const MAX_V = 40.0;
  List<PhysicsObject> things = [];

  World() {
    things.add(Ball(100, 500, 50));
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
  double x, y, vx, vy, ax, ay;

  PhysicsObject(this.x, this.y, {this.vx = 0, this.vy = 0, this.ax = 0, this.ay = 0});

  void applyGravity() {
    applyForce(0, World.G);
  }

  void applyForce(double ax, double ay) {
    this.ax += ax;
    this.ay += ay;
  }

  void updateInternal(Size size);

  void checkBoundaries(Size size) {
    if (x < 0 || x > size.width) {
      vx *= -1;
    }
    if (y < 0 || y > size.height) {
      vy *= -1;
    }
  }

  void update(Size size) {
    updateInternal(size);
    checkBoundaries(size);
    applyGravity();
    vx = vx + ax;
    vy = vy + ay;
    x = x + vx;
    y = y + vy;
    ax = 0;
    ay = 0;
  }

  void render(Canvas canvas);
}
