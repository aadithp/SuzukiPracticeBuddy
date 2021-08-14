import 'dart:math';
import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Piece.dart';

class Wheel extends StatefulWidget {
  final List<Piece> pieces;
  final colorMap;

  Wheel(this.pieces, this.colorMap);

  @override
  _WheelState createState() => _WheelState(colorMap);
}

class _WheelState extends State<Wheel> {
  final colorMap;

  _WheelState(this.colorMap);

  //The size of the widget
  Size get size => Size(350, 350);

  //Calculates the rotation angle of the sector
  double _rotateSector(int index) => (index / widget.pieces.length) * 2 * pi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: size.height + 35,
          width: size.width + 35,
          decoration: BoxDecoration(
            color: Colors.black12,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: size.height + 30,
          width: size.width + 30,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: size.height + 20,
          width: size.width + 20,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: size.height + 5,
          width: size.width + 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        Transform.rotate(
          angle: 0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              for (var piece in widget.pieces) ...[
                _buildCard(piece, colorMap[piece])
              ],
              for (var piece in widget.pieces) ...[_buildText(piece)]
            ],
          ),
        )
      ],
    );
  }

  //Creates the sectors
  _buildCard(Piece piece, Color color) {
    var _rotate = _rotateSector(widget.pieces.indexOf(piece));
    var _angle = 2 * pi / widget.pieces.length;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.rotate(
          angle: _rotate,
          child: ClipPath(
            clipper: _ArcClipper(_angle),
            child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  color: color, //add randomised colour selector here
                )),
          ),
        ),
        Transform.rotate(
          angle: _rotate,
          child: CustomPaint(
              painter: BorderPainter(_angle),
              child: Container(
                height: size.height,
                width: size.width,
              )),
        )
      ],
    );
  }

  //Creates the text on top of the sectors
  _buildText(Piece piece) {
    var _rotate = _rotateSector(widget.pieces.indexOf(piece));
    return Transform.rotate(
      angle: _rotate,
      child: ConditionalBuilder(
        condition: (widget.pieces.length > 4),
        builder: (context) {
          return Container(
            height: size.height / 1.03,
            width: size.width / 2,
            alignment: Alignment.topCenter,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                piece.name,
                style: TextStyle(
                    fontSize: size.height * 0.032, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        fallback: (context) {
          return Container(
            height: size.height / 1.06,
            width: size.width / 2,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 230),
            child: Text(
              piece.name,
              style:
                  TextStyle(fontSize: size.height * 0.05, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final double angle;

  BorderPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    Offset _center = size.center(Offset.zero);
    Rect _rect = Rect.fromCircle(center: _center, radius: size.width / 2);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.transparent;
    Path path = Path()
      ..moveTo(_center.dx, _center.dy)
      ..arcTo(_rect, -pi / 2 - angle / 2, angle, false)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ArcClipper extends CustomClipper<Path> {
  final double angle;

  _ArcClipper(this.angle);

  //Clips the circle according to the given angle creating an arc
  @override
  Path getClip(Size size) {
    Offset _center = size.center(Offset.zero);
    Rect _rect = Rect.fromCircle(center: _center, radius: size.width / 2);
    Path _path = Path()
      ..moveTo(_center.dx, _center.dy)
      ..arcTo(_rect, -pi / 2 - angle / 2, angle, false)
      ..close();
    return _path;
  }

  @override
  bool shouldReclip(_ArcClipper oldClipper) {
    //Returns true only if the angle is different
    return angle != oldClipper.angle;
  }
}
