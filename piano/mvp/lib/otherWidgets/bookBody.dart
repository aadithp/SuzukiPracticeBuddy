import 'package:SuzukiPracticeBuddy/screens/learning/currentPiecePopup.dart';
import 'package:SuzukiPracticeBuddy/screens/learning/piecePracticedButton.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:SuzukiPracticeBuddy/screens/review/PiecePreview.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

class BookBody extends StatefulWidget {
  final Piece currentPiece;
  final Function currentPiecePracticed;
  final bool buttonDisabled;
  final Function updateCurrentPiece;
  final List<Piece> allPieces;
  final int taskCounter;
  final Color color;

  BookBody(this.currentPiece, this.currentPiecePracticed, this.buttonDisabled,
      this.updateCurrentPiece, this.allPieces, this.taskCounter, this.color);

  @override
  _BookBodyState createState() => _BookBodyState(
      currentPiece,
      currentPiecePracticed,
      buttonDisabled,
      updateCurrentPiece,
      allPieces,
      taskCounter,
      color);
}

class _BookBodyState extends State<BookBody> {
  Piece currentPiece;
  Function currentPiecePracticed;
  bool buttonDisabled;
  Function updateCurrentPiece;
  List<Piece> allPieces;
  int taskCounter;
  Color color;

  _BookBodyState(
      this.currentPiece,
      this.currentPiecePracticed,
      this.buttonDisabled,
      this.updateCurrentPiece,
      this.allPieces,
      this.taskCounter,
      this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  builder: (BuildContext context) => CurrentPiecePopup(
                      currentPiece, updateCurrentPiece, allPieces),
                );
              },
              child: PiecePreview(currentPiece, color),
            ),
          ),
          ConditionalBuilder(
            condition: buttonDisabled,
            builder: (context) {
              return Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  'Already practiced for today.\n Come back tomorrow!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              );
            },
            fallback: (context) {
              return Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: 150,
                child: PiecePracticedButton(currentPiecePracticed, taskCounter),
              );
            },
          ),
        ],
      ),
    );
  }
}
