import 'package:SuzukiPracticeBuddy/screens/learning/piecePreviewPressable.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CurrentPiecePopup extends StatefulWidget {
  final Piece currentPiece;
  final Function updateCurrentPiece;
  final List<Piece> allPieces;

  CurrentPiecePopup(this.currentPiece, this.updateCurrentPiece, this.allPieces);

  @override
  _CurrentPiecePopupState createState() => _CurrentPiecePopupState(currentPiece, updateCurrentPiece, allPieces);
}

class _CurrentPiecePopupState extends State<CurrentPiecePopup> {
  Piece currentPiece;
  Function updateCurrentPiece;
  List<Piece> allPieces;
  _CurrentPiecePopupState(this.currentPiece, this.updateCurrentPiece, this.allPieces);

  final CarouselController carouselController = CarouselController();

  int colorIndex = 0;
  colorPicker() {
    List<Color> colors = [Colors.blueAccent, Colors.purple, Colors.orange, Colors.red, Colors.green];
    Color color = colors[colorIndex];
    colorIndex++;
    if (colorIndex >= 5) {
      colorIndex = 0;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
              items: allPieces
                  .map((piece) =>
              new PiecePreviewPressable(piece, updateCurrentPiece, currentPiece, colorPicker()))
                  .toList(),
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
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    carouselController.animateToPage(
                        allPieces
                            .map((piece) => piece.name)
                            .toList()
                            .indexOf(currentPiece.name),
                        duration: Duration(seconds: 3),
                        curve: Curves.ease);
                  },
                  child: Container(
                    width: 45,
                    child: Center(
                      child: Text(
                        'Current',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    carouselController.animateToPage(0,
                        duration: Duration(seconds: 3), curve: Curves.ease);
                  },
                  child: Container(
                    width: 45,
                    child: Center(
                      child: Text(
                        'Book 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    carouselController.animateToPage(25,
                        duration: Duration(seconds: 2), curve: Curves.ease);
                  },
                  child: Container(
                    width: 45,
                    child: Center(
                      child: Text(
                        'Book 2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    carouselController.animateToPage(39,
                        duration: Duration(seconds: 2), curve: Curves.ease);
                  },
                  child: Container(
                    width: 45,
                    child: Center(
                      child: Text(
                        'Book 3',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

