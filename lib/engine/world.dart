import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/objects/ball.dart';
import 'package:flutter_physice/engine/objects/generic_object.dart';

class World {
  static const G = 1.0;
  static const MAX_V = 40.0;
  List<PhysicsObject> things = [];

  World() {
    things.add(Ball(100, 500, 50));
    things.add(GenericObject(150, 500, 50));
  }

  void update(Size size) {
    things.forEach((element) {
      (element as PhysicsObject).update(size,element);
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

  PhysicsObject(this.x, this.y,
      {this.vx = 0, this.vy = 0, this.ax = 0, this.ay = 0});

  void applyGravity() {
    applyForce(0, World.G);
  }

  void applyForce(double ax, double ay) {
    this.ax += ax;
    this.ay += ay;
  }

  void applyReverseForce(double ax, double ay) {
    this.ax -= ax;
    this.ay -= ay;
  }

  void updateInternal(Size size);

  void checkBoundaries(Size size) {
    if (x <= 0 || x >= size.width) {
      vx *= -1;
    }
    if (y <= 0 || y >= size.height) {
      vy *= -1;
    }
    if (y > size.height) y = size.height - 1;
    if (y < 0) y = 1;
    if (x > size.width) x = size.width - 1;
    if (x < 0) x = 1;
  }

  int bounceflag = 0;
  void update(Size size,PhysicsObject object) {
    updateInternal(size);
    checkBoundaries(size);
    if(object is Ball){
      applyGravity();
    }

    if(object is GenericObject){
      applyReverseForce(1, World.G);
    }

    vx = vx + ax;
    vy = vy + ay;
    x = x + vx;
    y = y + vy;
    ax = 0;
    ay = 0;
  }

  void render(Canvas canvas);
}
