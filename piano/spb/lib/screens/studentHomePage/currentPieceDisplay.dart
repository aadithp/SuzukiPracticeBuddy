import 'package:flutter/material.dart';

class CurrentPieceDisplay extends StatefulWidget {
  @override
  _CurrentPieceDisplayState createState() => _CurrentPieceDisplayState();
}

class _CurrentPieceDisplayState extends State<CurrentPieceDisplay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: SizedBox(
            width: 330,
            height: 90,
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(140, 20, 0, 0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Container(
              decoration: BoxDecoration(color: Colors.pink),
            ),
          ),
        ),
      ],
    );
  }
}
