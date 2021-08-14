import 'dart:math';
import 'dart:ui';

import 'package:meta/meta.dart';

//SpinVelocity contains methods to calculate the rotation
class SpinVelocity {
  final double height;
  final double width;

  Map<int, Offset> quadrants = const{
    1: Offset(0.5, 0.5),
    2: Offset(-0.5, 0.5),
    3: Offset(-0.5, -0.5),
    4: Offset(0.5, -0.5)
  };

  SpinVelocity({@required this.height, @required this.width});

  //getVelocity calculates the velocity from the pixel per second
  double getVelocity(Offset position, Offset pps) {
    var quadrantIndex = getQuadrant(position);
    var quadrant = quadrants[quadrantIndex];
    return (quadrant.dx * pps.dx) + (quadrant.dy * pps.dx);
  }

  //Transforms coordinates into radians using positive y-axis as the starting point
  //Angle is 0 or pi when x is 0
  double offsetToRadians(Offset position) {
    var x = position.dx - width/2;
    var y = height/2 - position.dy;
    var angle = atan2(y, x);
    return _normaliseAngle(angle);
  }

  //Radians go from 0 to +pi when y is positive and 0 to -pi when y is negative
  //_normaliseAngle changes it to go from 0 to +2pi starting and ending at the positive y-axis
  double _normaliseAngle(double angle) {
    if(angle > 0) {
      if(angle > pi/2) {
        return 5 * pi/2 - angle;
      } else {
        return pi/2 - angle;
      }
    } else {
      return pi/2 - angle;
    }
  }

  //getQuadrant calculates the quadrant from the coordinates
  int getQuadrant(Offset position) {
    if (position.dx > width/2) {
      if(position.dy > height/2) {
        return 2;
      } else return 1;
    } else {
      if(position.dy > height/2) {
        return 3;
      } else return 4;
    }
  }

  //Converts pixels per seconds to radians
  //Assumes that 1000 pps = 2pi
  double pixelPerSecondToRadians(double pps) {
    return pps * 2 * pi / 1000;
  }
}
