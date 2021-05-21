import 'package:SuzukiPracticeBuddy/otherWidgets/bookBody.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/leftBookCover.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/rightBookCover.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItemWidget.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP1.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP8.dart';
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

class TP7 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP7State();
}

class TP7State extends State<TP7> {
  //Display properties
  double _alpha1 = 1;
  double _alpha2 = 0;
  double _alpha3 = 0;
  double _alpha4 = 0;

  final double width = 175;
  final double height = 175;

  Image waterColour;
  Image yellowExplosion;
  Image clouds;
  Image colourfulNature;


  @override
  initState() {
    waterColour = Image.asset('assets/backgrounds/water_colour_space.jpg');
    yellowExplosion = Image.asset('assets/backgrounds/yellow_explosion.jpg');
    clouds = Image.asset('assets/backgrounds/clouds.jpg');
    colourfulNature = Image.asset('assets/backgrounds/colourful_nature.jpg');
    toggleOpacity();
    super.initState();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/backgrounds/water_colour_space.jpg'), context);
    precacheImage(AssetImage('assets/backgrounds/yellow_explosion.jpg'), context);
    precacheImage(AssetImage('assets/backgrounds/clouds.jpg'), context);
    precacheImage(AssetImage('assets/backgrounds/colourful_nature.jpg'), context);
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
                            child: Text("Once you have enough coins, you can buy items in the shop!", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                        )
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: _alpha3,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: [
                            SizedBox(),
                            SizedBox(),
                            Center(
                                child: InkWell(
                                  child: InkWell(
                                    child: Container(
                                      child: Container(
                                        width: width,
                                        height: height,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              'assets/backgrounds/water_colour_space.jpg',
                                            ),
                                          ),
                                          border: Border.all(color: Colors.black, width: 2),
                                        ),
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.75, 0, 0),
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: SizedBox(
                                                  width: width,
                                                  height: height / 4,
                                                  child: Container(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.77, 0, 0),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: <Widget>[
                                                  FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      'Night clouds background',
                                                      style: TextStyle(
                                                          fontSize: height * 0.08, color: Colors.white),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/dollar.png',
                                                        width: 10,
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '1500',
                                                        style: TextStyle(
                                                            fontSize: height * 0.08, color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Center(
                                child: InkWell(
                                  child: InkWell(
                                    child: Container(
                                      child: Container(
                                        width: width,
                                        height: height,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              'assets/backgrounds/yellow_explosion.jpg',
                                            ),
                                          ),
                                          border: Border.all(color: Colors.black, width: 2),
                                        ),
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.75, 0, 0),
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: SizedBox(
                                                  width: width,
                                                  height: height / 4,
                                                  child: Container(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.77, 0, 0),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: <Widget>[
                                                  FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      'Yellow explosion background',
                                                      style: TextStyle(
                                                          fontSize: height * 0.08, color: Colors.white),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/dollar.png',
                                                        width: 10,
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '1500',
                                                        style: TextStyle(
                                                            fontSize: height * 0.08, color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Center(
                                child: InkWell(
                                  child: InkWell(
                                    child: Container(
                                      child: Container(
                                        width: width,
                                        height: height,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              'assets/backgrounds/clouds.jpg',
                                            ),
                                          ),
                                          border: Border.all(color: Colors.black, width: 2),
                                        ),
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.75, 0, 0),
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: SizedBox(
                                                  width: width,
                                                  height: height / 4,
                                                  child: Container(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.77, 0, 0),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: <Widget>[
                                                  FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      'Cartoon clouds background',
                                                      style: TextStyle(
                                                          fontSize: height * 0.08, color: Colors.white),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/dollar.png',
                                                        width: 10,
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '1500',
                                                        style: TextStyle(
                                                            fontSize: height * 0.08, color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Center(
                                child: InkWell(
                                  child: InkWell(
                                    child: Container(
                                      child: Container(
                                        width: width,
                                        height: height,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                              'assets/backgrounds/colourful_nature.jpg',
                                            ),
                                          ),
                                          border: Border.all(color: Colors.black, width: 2),
                                        ),
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.75, 0, 0),
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: SizedBox(
                                                  width: width,
                                                  height: height / 4,
                                                  child: Container(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(0, height * 0.77, 0, 0),
                                              alignment: Alignment.center,
                                              child: Column(
                                                children: <Widget>[
                                                  FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      'Natural colour background',
                                                      style: TextStyle(
                                                          fontSize: height * 0.08, color: Colors.white),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/dollar.png',
                                                        width: 10,
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '1500',
                                                        style: TextStyle(
                                                            fontSize: height * 0.08, color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
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
                                      pageBuilder: (c, a1, a2) => TP8(),
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
