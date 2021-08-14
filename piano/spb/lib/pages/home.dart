import 'dart:async';
import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/coins.dart';
import 'package:SuzukiPracticeBuddy/pages/homeLoadingPage.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:SuzukiPracticeBuddy/screens/review/reviewPageLoading.dart';
import 'package:SuzukiPracticeBuddy/screens/studentHomePage/Promotion.dart';
import 'package:SuzukiPracticeBuddy/screens/studentHomePage/StudentPage.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../screens/listening/Listening.dart';

int currentPieceId;

class Home extends StatefulWidget {
  final int pageIndex;

  Home(this.pageIndex);

  @override
  _HomeState createState() => _HomeState(pageIndex);
}

class _HomeState extends State<Home> {
  //current page index
  int pageIndex;

  _HomeState(this.pageIndex);

  //The current piece
  Piece currentPiece;
  List<Piece> reviewPieces;

  //Badge display properties
  bool selected = false;
  int taskCounter;
  List<bool> doneStatus = [];

  final Map<String, int> badgeHistory = {
    "Mon": 0,
    "Tue": 0,
    "Wed": 0,
    "Thu": 0,
    "Fri": 0,
    "Sat": 0,
    "Sun": 0,
  };

  //Current day of the week
  final String day = DateFormat('E').format(DateTime.now());

  //Pages available on the navigation bar
  Widget getPages(index) {
    Widget widget;
    switch (index) {
      case 0:
        widget = Listening(updateListening);
        break;
      case 1:
        widget = StudentPage();
        break;
      case 2:
        widget = ReviewPageLoading(updateReview);
        break;
    }
    return widget;
  }

  //Reads database and returns list of booleans representing completed tasks
  Future<List<bool>> _getDoneStatus(String day) async {
    var res = await GeneralDBProvider.instance.getBadgeHistory(day);
    List<String> statusStrings = res[0]['doneStatus'].split(",");
    doneStatus.clear();
    for (String s in statusStrings) {
      switch (s) {
        case "true":
          doneStatus.add(true);
          break;
        case "false":
          doneStatus.add(false);
          break;
      }
    }
    return doneStatus;
  }

  //Reads database and returns progress made on the given day
  Future<int> _getTaskCounter(String day) async {
    var res = await GeneralDBProvider.instance.getBadgeHistory(day);
    taskCounter = res[0]['taskCounter'];
    return taskCounter;
  }

  getReviewList() async {
    List<dynamic> res = await GeneralDBProvider.instance.getReviewList();
    reviewPieces = [];
    for (int x = 0; x < res.length; x++) {
      reviewPieces.add(Piece.convertToPiece(res[x]));
    }
    return "Done";
  }

  //Updates progress and writes to the database
  updateReview(context) async {
    doneStatus = await _getDoneStatus(day);
    taskCounter = await _getTaskCounter(day);
    //award user coins for completing task
    await GeneralDBProvider.instance.awardCoins(100);

    final player = AudioCache();

    if (!doneStatus[1]) {
      taskCounter++;

      doneStatus[1] = true;
      GeneralDBProvider.instance
          .updateBadgeHistory(day, taskCounter, doneStatus);
      player.load('pianoJingle.mp3');
      player.play('pianoJingle.mp3');
      SystemChrome.setEnabledSystemUIOverlays([]);
      await showDialog(
        context: context,
        builder: (BuildContext context) => Promotion(taskCounter),
      );
    } else {
      player.load('pianoJingle.mp3');
      player.play('pianoJingle.mp3');
      await showDialog(
        context: context,
        builder: (BuildContext context) => Coins(),
      );
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     PageRouteBuilder(
      //         pageBuilder: (context, _, __) =>
      //             Home(1)),
      //         (r) => false);
    }
    // setState(() {});
  }

  //Updates progress and writes to the database
  updateListening(context) async {
    doneStatus = await _getDoneStatus(day);
    taskCounter = await _getTaskCounter(day);
    //award user coins for completing task
    await GeneralDBProvider.instance.awardCoins(100);

    if (!doneStatus[2]) {
      taskCounter++;

      doneStatus[2] = true;
      GeneralDBProvider.instance
          .updateBadgeHistory(day, taskCounter, doneStatus);
      final player = AudioCache();
      player.load('pianoJingle.mp3');
      player.play('pianoJingle.mp3');

      SystemChrome.setEnabledSystemUIOverlays([]);
      await showDialog(
        context: context,
        builder: (BuildContext context) => Promotion(taskCounter),
      );
    } else {
      final player = AudioCache();
      player.load('pianoJingle.mp3');
      player.play('pianoJingle.mp3');
      await showDialog(
        context: context,
        builder: (BuildContext context) => Coins(),
      );
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     PageRouteBuilder(
      //         pageBuilder: (context, _, __) =>
      //             Home(1)),
      //         (r) => false);
    }
  }

  // //resets the page after navigating to it from the navigation bar.
  // //(used to fix shop navigation issue)
  // void resetPage() {
  //   Navigator.pushReplacement(
  //     context,
  //     PageRouteBuilder(
  //       transitionDuration: Duration.zero,
  //       pageBuilder: (_, __, ___) => Home(1),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: AppBar(
      //     // title: Text(
      //     //   'Suzuki Practice Buddy',
      //     //   style: TextStyle(color: Colors.white, fontSize: 18),
      //     // ),
      //     backgroundColor: Colors.black,
      //     actions: [
      //         Container(
      //         alignment: Alignment.centerLeft,
      //         child: IconButton(
      //           icon: Icon(Icons.settings),
      //           onPressed: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => Settings()))
      //                 .then((v) => setState(() {}));
      //           },
      //         ),
      //       ),
      //       //money symbol widget goes here
      //       Center(
      //         child: Text(
      //           '£',
      //           style: TextStyle(fontSize: 25, color: Colors.lightGreen),
      //         ),
      //       ),
      //       //money amount widget here
      //       Center(
      //         child: StreamBuilder<Object>(
      //             stream: appBloc.currencyStream,
      //             initialData: currencyValue,
      //             builder: (context, snapshot) {
      //               return Text(
      //                 snapshot.data.toString(),
      //                 style: TextStyle(color: Colors.yellow),
      //               );
      //             }),
      //       ),
      //     ],
      //   ),
      // ),
      //chooses page to build from list of pages based on pageIndex given by navigation bar
      body: getPages(pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note, color: Colors.white),
            label: 'Listening',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, color: Colors.white),
            label: 'Review',
          ),
        ],
        onTap: (index) {
          index == 1
              ? Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomeLoadingPage(1),
                  ),
                )
              : setState(() {
                  pageIndex = index;
                });
        },
      ),
    );
  }
}
