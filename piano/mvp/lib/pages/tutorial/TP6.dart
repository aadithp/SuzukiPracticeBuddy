import 'package:SuzukiPracticeBuddy/otherWidgets/bookBody.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/leftBookCover.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/rightBookCover.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP1.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP7.dart';
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
import 'package:flutter_svg/flutter_svg.dart';

class TP6 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP6State();
}

class TP6State extends State<TP6> {
  //Display properties
  double _alpha1 = 1;
  double _alpha2 = 0;
  double _alpha3 = 0;
  double _alpha4 = 0;
  double _alpha5 = 0;


  @override
  initState() {
    super.initState();
    toggleOpacity();
  }

  toggleOpacity() {
    Future.delayed(Duration(seconds: 1),
            () => setState(() {
          _alpha2 = 1;
        })
    );
    Future.delayed(Duration(seconds: 2),
            () => setState(() {
          _alpha3 = 1;
        })
    );
    Future.delayed(Duration(seconds: 3),
        () => setState(() {
      _alpha4 = 1;
    })
    );
    Future.delayed(Duration(seconds: 4),
        () => setState(() {
      _alpha5 = 1;
    })
    );
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
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: _alpha2,
                        child:
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Completing a task will give you a badge and 100 coins.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                        )
                    ),
                  ),
                  SizedBox(),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.23,
                      child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: _alpha3,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Finish all tasks in one day to earn a gold badge!", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                          )
                      ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.35,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      opacity: _alpha4,
                      duration: Duration(milliseconds: 500),
                      child: SvgPicture.asset('assets/gold_badge_3.svg', width: 300, height: 300),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.74,
                    left: 20,
                    right: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _alpha4,
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          "100",
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            shadows: <Shadow>[
                              Shadow(
                                blurRadius: 3.0,
                                color: Colors.yellowAccent,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.75,
                    left: 0,
                    right: MediaQuery.of(context).size.height*0.07,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _alpha4,
                        duration: Duration(milliseconds: 500),
                        child:                   Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                          child: Center(
                            child: Image.asset(
                              'assets/dollar.png',
                              height: 23,
                              width: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.8,
                      left: MediaQuery.of(context).size.width*0.8,
                      child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: _alpha5,
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
                                      pageBuilder: (c, a1, a2) => TP7(),
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
                  _alpha5 == 0 ? Positioned(
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
