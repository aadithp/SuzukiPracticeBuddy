import 'package:SuzukiPracticeBuddy/otherWidgets/bookBody.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/leftBookCover.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/rightBookCover.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP1.dart';
import 'package:SuzukiPracticeBuddy/screens/learning/currentPiecePopup.dart';
import 'package:SuzukiPracticeBuddy/screens/learning/piecePreviewPressable.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:SuzukiPracticeBuddy/screens/review/PiecePreview.dart';
import 'package:SuzukiPracticeBuddy/screens/review/SpinningWheel.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Wheel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TP5.dart';

class TP4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP4State();
}

class TP4State extends State<TP4> {
  //Display properties
  double _alpha1 = 0;
  double _alpha2 = 0;
  double _alpha3 = 0;

  List<Piece> reviewPieces = [
    Piece(100, "Variation A right hand"),
    Piece(101, "Variation A left hand"),
    Piece(102, "Variation B right hand"),
    Piece(103, "Variation B left hand"),
    Piece(104, "Variation C right hand"),
    Piece(105, "Variation C left hand"),
    Piece(106, "Twinkle Theme right hand"),
    Piece(107, "Twinkle Theme left hand"),
  ];
  Piece reviewPiece;
  var colorMap;

  @override
  initState() {
    super.initState();
    colorMap = getColors(reviewPieces);
    toggleOpacity();
  }

  toggleOpacity() {
    Future.delayed(Duration(seconds: 1),
            () => setState(() {
          _alpha1 = 1;
        })
    );
  }


  List<MaterialColor> colorList = [
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.lightBlue,
    Colors.purple
  ];

  int colorIndex;

  getColor() {
    MaterialColor color;
    if (colorIndex == null) {
      colorIndex = 0;
    }
    if (colorIndex >= 5) {
      colorIndex = 0;
    }
    color = colorList[colorIndex];
    colorIndex++;
    return color;
  }

  //checks no 2 colours are the same next to each other on the wheel
  checkColors(Map colorMap) {
    Color previousColor = colorList[0];
    colorMap.forEach(
          (key, value) {
        if (previousColor != null) {
          while (value == previousColor) {
            if (colorList.indexOf(value) + 1 >= 5) {
              value = colorList[0];
            } else {
              value = colorList[colorList.indexOf(value) + 1];
            }
          }
          colorMap[key] = value;
          previousColor = value;
        }
      },
    );
    Color firstColor = colorMap.values.first;
    Color lastColor = colorMap.values.last;
    while (firstColor == lastColor) {
      if (colorList.indexOf(lastColor) + 1 >= 5) {
        lastColor = colorList[0];
      } else {
        lastColor = colorList[colorList.indexOf(lastColor) + 1];
      }
    }
    colorMap[colorMap.keys.last] = lastColor;
    return colorMap;
  }

  getColors(List<Piece> reviewPieces) {
    Map colorMap = new Map();
    for (Piece piece in reviewPieces) {
      colorMap[piece] = getColor();
    }
    colorMap = checkColors(colorMap);
    return colorMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _alpha1,
            child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.14,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("These are the pieces that will help you learn Honeybee.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                      )
                  ),
                  SizedBox(),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.23,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text("Try spinning the wheel to select a piece to review.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                      )
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.35,
                    left: 0,
                    right: 0,
                    child: SpinningWheel(
                      image: Wheel(reviewPieces, colorMap),
                      height: 485,
                      width: 385,
                      secondaryImage: Image.asset('assets/pin.png'),
                      secondaryImageHeight: 70,
                      secondaryImageWidth: 70,
                      pieces: reviewPieces,
                      onEnd: (Piece r) {
                        setState(() {
                          reviewPiece = r;
                        });
                        _alpha2 = 1;
                        Future.delayed(Duration(seconds: 1),
                                () => setState(() {
                              _alpha3 = 1;
                            })
                        );
                        // _wheelPos = -500;
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          setState(() {});
                        });
                      },
                      colorMap: colorMap,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.93,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    top: 720,
                    child: AnimatedOpacity(
                        opacity: _alpha2,
                        duration: Duration(milliseconds: 700),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Good job!", style: TextStyle(fontSize: 22, color: Colors.orange), textAlign: TextAlign.center,)
                        )
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.8,
                      left: MediaQuery.of(context).size.width*0.8,
                      child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: _alpha3,
                          child: ClipOval(
                            child: Material(
                              color: Colors.blue, // button color
                              child: InkWell(
                                splashColor: Colors.white, // inkwell color
                                child: SizedBox(width: 56, height: 56, child: Icon(Icons.arrow_forward_rounded, color: Colors.white,)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => TP5(),
                                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                      )
                  ),
                  _alpha3 == 0 ? Positioned(
                      top: MediaQuery.of(context).size.height*0.8,
                      left: MediaQuery.of(context).size.width*0.8,
                      child: Container(
                        width: 56,
                        height: 56,
                        color: Colors.white,
                      )
                  ) : Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        color: Colors.transparent,
                      )
                  )
                ]
            ))
    );
  }
}
