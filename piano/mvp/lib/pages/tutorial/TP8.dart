import 'package:SuzukiPracticeBuddy/otherWidgets/bookBody.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/leftBookCover.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/rightBookCover.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItemWidget.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP1.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP9.dart';
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

class TP8 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP8State();
}

class TP8State extends State<TP8> {
  //Display properties
  double _alpha1 = 1;
  double _alpha2 = 0;
  double _alpha3 = 0;
  double _alpha4 = 0;

  final double width = 175;
  final double height = 175;

  @override
  initState() {
    toggleOpacity();
    super.initState();
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
                    top: MediaQuery.of(context).size.height*0.36,
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: _alpha2,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("You can earn achievements by completing tasks and buying items.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                        )
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.47,
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: _alpha3,
                        child:
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Visit the Achievements section in the settings page to find out more!", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                        )
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.8,
                      left: MediaQuery.of(context).size.width*0.8,
                      child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: _alpha4,
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
                                      pageBuilder: (c, a1, a2) => TP9(),
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
                  _alpha4 == 0 ? Positioned(
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
