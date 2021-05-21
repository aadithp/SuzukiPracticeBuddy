import 'dart:async';
import 'package:SuzukiPracticeBuddy/databases/database.dart';
import 'package:SuzukiPracticeBuddy/screens/review/ReviewPieceIds.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import '../review/Piece.dart';
import '../review/PiecePreview.dart';
import 'Piece.dart';
import 'Wheel.dart';
import 'SpinningWheel.dart';
import '../../databases/generalDatabase.dart';

class SpinningWheelController {
  bool Function() startOrStop;
}

class ReviewPage extends StatefulWidget {
  final List<Piece> reviewPieces;
  final int taskCounter;
  final Function(dynamic) updateParent;
  final colorMap;

  ReviewPage(
      this.reviewPieces, this.taskCounter, this.updateParent, this.colorMap);

  @override
  _ReviewPageState createState() => _ReviewPageState(
      reviewPieces, this.taskCounter, this.updateParent, this.colorMap);
}

class _ReviewPageState extends State<ReviewPage> {
  List<Piece> reviewPieces;
  final Function(dynamic) updateParent;
  final int taskCounter;
  final colorMap;
  List<bool> doneStatus = [];

  _ReviewPageState(
      this.reviewPieces, this.taskCounter, this.updateParent, this.colorMap);

  //Piece to be reviewed
  Piece reviewPiece;

  //True if wheel has been spun
  bool spun = false;
  final SpinningWheelController spinningWheel = SpinningWheelController();
  double _wheelPos = 100;
  double _previewPos = 560;
  double _buttonAlpha = 0;
  Timer _previewTimer;
  Timer _buttonTimer;

  removeFromReviewList(Piece piece) async {
    var res = await GeneralDBProvider.instance.removeFromReviewList(piece);
    return res;
  }

  renewReviewList() async {
    int currentPieceId = await GeneralDBProvider.instance.getCurrentPieceId();
    var res = await DBProvider.db.getReviewPieceIds(currentPieceId);
    ReviewPieceIds reviewPieceIds = ReviewPieceIds.convertToList(res[0]);
    res = await DBProvider.db.updateReviewPiecesTable(reviewPieceIds);
  }

  getReviewList() async {
    await renewReviewList();
    List<dynamic> res = await GeneralDBProvider.instance.getReviewList();
    reviewPieces = [];
    for (int x = 0; x < res.length; x++) {
      reviewPieces.add(Piece.convertToPiece(res[x]));
    }
  }

  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    player.load('pianoJingle.mp3');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ConditionalBuilder(
        condition: reviewPieces.isNotEmpty && reviewPieces.length > 1,
        builder: (context) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedPositioned(
                duration: Duration(seconds: 3),
                curve: Curves.easeInOutQuad,
                top: _wheelPos,
                right: 0,
                left: 0,
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
                      spun = true;
                    });
                    _wheelPos = -500;
                    _previewTimer =
                        new Timer(const Duration(milliseconds: 400), () {
                      setState(() {
                        _previewPos = 300;
                      });
                    });
                    _buttonTimer = new Timer(const Duration(seconds: 2), () {
                      setState(() {
                        _buttonAlpha = 1;
                      });
                    });
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {});
                    });
                  },
                  colorMap: colorMap,
                ),
              ),
              AnimatedPositioned(
                  top: _previewPos,
                  duration: Duration(milliseconds: 2500),
                  curve: Curves.fastOutSlowIn,
                  child: spun
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              PiecePreview(reviewPiece, colorMap[reviewPiece]),
                          height: 150,
                          width: 150,
                        )
                      : Container()),
              Positioned(
                top: 450,
                child: AnimatedOpacity(
                  duration: Duration(seconds: 2),
                  opacity: _buttonAlpha,
                  child: Container(
                    child: GestureDetector(
                      onTap: () async {
                        //award user coins for completing task
                        removeFromReviewList(reviewPiece);
                        updateParent(context);
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 120,
                          height: 50,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.lightGreenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'Practiced',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        fallback: (context) {
          return ConditionalBuilder(
            condition: reviewPieces.isNotEmpty && reviewPieces.length == 1,
            builder: (context) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 250,
                    child: Container(
                      child: Text(
                        'Review piece:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 300,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: PiecePreview(
                            reviewPieces[0], colorMap[reviewPieces[0]]),
                        height: 150,
                        width: 150,
                      )),
                  Positioned(
                    top: 450,
                    child: GestureDetector(
                      onTap: () async {
                        removeFromReviewList(reviewPieces[0]);
                        await getReviewList();
                        updateParent(context);
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 120,
                          height: 50,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.lightGreenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'Practiced',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            fallback: (context) {
              return Center(
                child: Text(
                  'Learn a piece to review it!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
