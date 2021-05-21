import 'package:SuzukiPracticeBuddy/otherWidgets/bookBody.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/leftBookCover.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/rightBookCover.dart';
import 'package:SuzukiPracticeBuddy/screens/learning/currentPiecePopup.dart';
import 'package:SuzukiPracticeBuddy/screens/learning/piecePreviewPressable.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:SuzukiPracticeBuddy/screens/review/PiecePreview.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TP3.dart';

class TP2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP2State();
}

class TP2State extends State<TP2> {
  //Display properties
  double _alpha1 = 0;
  double _alpha2 = 0;
  double _alpha3 = 0;

  //book properties
  bool bookOpen = false;
  double _leftCoverPos = -125;
  double _rightCoverPos = -125;
  final CarouselController carouselController = CarouselController();

  List<Piece> allPieces = [Piece(100, "Variation A right hand"), Piece(108, "Honeybee")];
  List<Color> colors = [Colors.blueAccent, Colors.red];

  Piece currentPiece = Piece(100, "Variation A right hand");

  @override
  initState() {
    super.initState();
    toggleOpacity();
  }

  toggleOpacity() {
    Future.delayed(Duration(seconds: 1),
            () => setState(() {
              _alpha1 = 1;
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
          opacity: _alpha1,
          duration: Duration(seconds: 1),
          child: Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height*0.18,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text("First, let's choose a piece to learn.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                  )
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height*0.22,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text("Try selecting the second piece in the book below.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                  )
              ),

              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Tap to change piece',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      ),
                      Container(
                        width: 140,
                        height: 140,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    width: 400,
                                    height: 300,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Tap a piece to select it',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        ),
                                        CarouselSlider(
                                          items: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                  currentPiece = allPieces[0];
                                                });
                                              },
                                              child: ConditionalBuilder(
                                                condition: currentPiece.name == allPieces[0].name,
                                                builder: (context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.green,
                                                          width: 4,
                                                        ),
                                                        borderRadius: BorderRadius.circular(12)),
                                                    child: PiecePreview(allPieces[0], colors[0]),
                                                  );
                                                },
                                                fallback: (context) {
                                                  return PiecePreview(allPieces[0], colors[0]);
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  currentPiece = allPieces[1];
                                                  Navigator.pop(context);
                                                  _alpha2 = 1;
                                                  Future.delayed(Duration(seconds: 1),
                                                          () => setState(() {
                                                        _alpha3 = 1;
                                                      })
                                                  );
                                                });
                                              },
                                              child: ConditionalBuilder(
                                                condition: currentPiece.name == allPieces[1].name,
                                                builder: (context) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.green,
                                                          width: 4,
                                                        ),
                                                        borderRadius: BorderRadius.circular(12)),
                                                    child: PiecePreview(allPieces[1], colors[1]),
                                                  );
                                                },
                                                fallback: (context) {
                                                  return PiecePreview(allPieces[1], colors[1]);
                                                },
                                              ),
                                            ),
                                          ],
                                          options: CarouselOptions(
                                            height: 150,
                                            viewportFraction: 0.5,
                                            initialPage: allPieces
                                                .map((piece) => piece.name)
                                                .toList()
                                                .indexOf(currentPiece.name),
                                            enableInfiniteScroll: false,
                                            reverse: false,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                          carouselController: carouselController,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            );
                          },
                          child: allPieces.indexOf(currentPiece) != 0 && allPieces.indexOf(currentPiece) != 1 ? PiecePreview(currentPiece, colors[0]) : PiecePreview(currentPiece, colors[allPieces.indexOf(currentPiece)]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                top: 0,
                left: _leftCoverPos,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _leftCoverPos = bookOpen ? -125 : -325;
                      _rightCoverPos = bookOpen ? -125 : -325;
                      bookOpen = !bookOpen;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: LeftBookCover(),
                  ),
                ),
                duration: Duration(seconds: 1),
                curve: Curves.ease,
              ),
              AnimatedPositioned(
                top: 0,
                left: 0,
                right: _rightCoverPos,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _rightCoverPos = bookOpen ? -125 : -325;
                      _leftCoverPos = bookOpen ? -125 : -325;
                      bookOpen = !bookOpen;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: RightBookCover(),
                  ),
                ),
                duration: Duration(seconds: 1),
                curve: Curves.ease,
              ),

              Positioned(
                top: MediaQuery.of(context).size.height*0.7,
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
                                  pageBuilder: (c, a1, a2) => TP3(),
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
            ],
          )),
    );
  }
}
