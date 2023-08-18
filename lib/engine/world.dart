import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_physice/engine/objects/ball.dart';

class World {
  static const G = 4.0;
  static const MAX_V = 40.0;
  static const PADDING = 50.0;
  static const SUB_STEPS = 20;

  List<PhysicsObject> things = [];
  final int interval = 1;
  int frameCount = 0;

  World() {}

  void onClick(double mouseX, double mouseY) {
    // things.add(Ball(mouseX, mouseY, 50, vx: 0));
  }

  void update(Size size) {
    for (var ball in things) {
      for (var other in things) {
        if (ball != other) {
          final d = ball.distance(other);
          final r = (ball as Ball).r;
          if (d < r * 2) {
            final dToMove = (r * 2 - d)/2;
            final theta = atan2(other.y - ball.y, other.x - ball.x);
            final xDelta = dToMove * cos(theta);
            final yDelta = dToMove * sin(theta);
            bool moveBallX = true;
            bool moveBallY = true;
            bool moveOtherX = true;
            bool moveOtherY = true;
            var temp = ball.x - xDelta;
            if (temp < World.PADDING || temp > size.width - World.PADDING) {
              moveBallX = false;
            }
            temp = ball.y - yDelta;
            if (temp < World.PADDING || temp > size.height - World.PADDING) {
              moveBallY = false;
            }
            temp = other.x + xDelta;
            if (temp < World.PADDING || temp > size.width - World.PADDING) {
              moveOtherX = false;
            }
            temp = other.y + yDelta;
            if (temp < World.PADDING || temp > size.height - World.PADDING) {
              moveOtherY = false;
            }
            if (moveBallX) {
              if (moveOtherX) {
                ball.x -= xDelta;// / World.SUB_STEPS;
                other.x += xDelta;// / World.SUB_STEPS;
              } else {
                ball.x -= (2 * xDelta);// / World.SUB_STEPS;
              }
            } else {
              if (moveOtherY) {
                other.x += (2 * xDelta);// / World.SUB_STEPS;
              }
            }
            if (moveBallY) {
              if (moveOtherY) {
                ball.y -= yDelta;// / World.SUB_STEPS;
                other.y += yDelta;// / World.SUB_STEPS;
              } else {
                ball.y -= (2 * yDelta);// / World.SUB_STEPS;
              }
            } else {
              if (moveOtherY) {
                other.y += (2 * yDelta);// / World.SUB_STEPS;
              }
            }
          }
        }
      }
      ball.update(size);
    }

  }

  void render(Canvas canvas) {
    frameCount++;
    if (frameCount >= interval) {
      things.add(Ball(200, 100, 5, vx: 10));
      frameCount = 0;
    }
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
    this.ax += ax / World.SUB_STEPS;
    this.ay += ay / World.SUB_STEPS;
  }

  void updateInternal(Size size);

  void checkBoundaries(Size size) {
    // if (x <= 0 || x >= size.width) {
    //   vx *= -1;
    // }
    // if (y <= 0 || y >= size.height) {
    //   vy *= -1;
    // }
    if (y > size.height - World.PADDING) y = size.height - World.PADDING;
    if (y < World.PADDING) y = World.PADDING;
    if (x > size.width - World.PADDING) x = size.width - World.PADDING;
    if (x < World.PADDING) x = World.PADDING;
  }

  double distance(PhysicsObject other);

  void update(Size size) {
    updateInternal(size);
    applyGravity();
    vx = vx + ax / World.SUB_STEPS;
    vy = vy + ay / World.SUB_STEPS;
    x = x + vx / World.SUB_STEPS;
    y = y + vy / World.SUB_STEPS;
    ax = 0;
    ay = 0;
    checkBoundaries(size);
  }

  void render(Canvas canvas);
}
