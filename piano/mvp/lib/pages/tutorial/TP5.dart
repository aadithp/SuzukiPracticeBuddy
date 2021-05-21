import 'package:SuzukiPracticeBuddy/otherWidgets/bookBody.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/leftBookCover.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/rightBookCover.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP1.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP6.dart';
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

class TP5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP5State();
}

class TP5State extends State<TP5> {
  //Display properties
  double _alpha1 = 1;
  double _alpha2 = 0;
  double _alpha3 = 0;
  double _alpha4 = 0;
  double _alpha5 = 0;
  double _alpha6 = 0;

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
                            child: Text("Practising your listening is also very important.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
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
                              child: Text("You can track your listening by pressing the button on the listening page.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                          )
                      ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.40,
                      child: AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: _alpha4,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Give this a try with the button below.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                          )
                      )
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.42,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: _alpha4,
                      child: Container(
                        color: Colors.green,
                        width: 130,
                        height: 50,
                        margin: EdgeInsets.all(90),
                        // ignore: deprecated_member_use
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _alpha5 = 1;
                              Future.delayed(Duration(seconds: 1),
                              () => setState(() {
                                _alpha6 = 1;
                              }));
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.73,
                    child: AnimatedOpacity(
                        opacity: _alpha5,
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
                          opacity: _alpha6,
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
                                      pageBuilder: (c, a1, a2) => TP6(),
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
                  _alpha6 == 0 ? Positioned(
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
