import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/loadingWidgetNoAppbar.dart';
import 'package:SuzukiPracticeBuddy/screens/review/ReviewPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Piece.dart';
import 'ReviewPage.dart';

class ReviewPageLoading extends StatefulWidget {
  final Function(dynamic) updateParent;

  ReviewPageLoading(this.updateParent);

  @override
  _ReviewPageLoadingState createState() =>
      _ReviewPageLoadingState(this.updateParent);
}

class _ReviewPageLoadingState extends State<ReviewPageLoading> {
  //Pieces to select from
  List<Piece> reviewPieces;
  final Function(dynamic) updateParent;
  int taskCounter;

  _ReviewPageLoadingState(this.updateParent);

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
  checkColors(Map colorMap) async {
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

  getColors(List<Piece> reviewPieces) async {
    Map colorMap = new Map();
    for (Piece piece in reviewPieces) {
      colorMap[piece] = getColor();
    }
    colorMap = await checkColors(colorMap);
    return colorMap;
  }

  var colorMap;

  getReviewList() async {
    List<dynamic> res = await GeneralDBProvider.instance.getReviewList();
    String day = DateFormat('E').format(DateTime.now());
    var hist = await GeneralDBProvider.instance.getBadgeHistory(day);
    taskCounter = hist[0]['taskCounter'];
    reviewPieces = [];
    for (int x = 0; x < res.length; x++) {
      reviewPieces.add(Piece.convertToPiece(res[x]));
    }
    if (reviewPieces.isNotEmpty) {
      colorMap = await getColors(reviewPieces);
    }
    return "Done";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getReviewList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingWidgetNoAppBar();
        }
        return ReviewPage(reviewPieces, taskCounter, updateParent, colorMap);
      },
    );
  }
}
