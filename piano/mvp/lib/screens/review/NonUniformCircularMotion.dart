import 'dart:math';

import 'package:meta/meta.dart';

class NonUniformCircularMotion {
  final double resistance;

  NonUniformCircularMotion({@required this.resistance});

  //acceleration is dependent on the resistance
  double get acceleration => resistance * -4 * pi;

  //distance calculates the distance covered in a certain amount of time at a certain velocity
  double distance(double velocity, double time) {
    return (velocity * time) + (acceleration * pow(time, 2))/2;
  }

  //duration calculates the duration of the motion at a certain velocity and acceleration
  double duration(double velocity) {
    return -velocity / acceleration;
  }

  double modulo(double angle) {
    return angle % (2 * pi);
  }
}