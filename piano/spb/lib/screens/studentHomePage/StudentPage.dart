import 'package:SuzukiPracticeBuddy/otherWidgets/bookBody.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/leftBookCover.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/loadingWidget.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/rightBookCover.dart';
import 'package:SuzukiPracticeBuddy/pages/achievements/achievement.dart';
import 'package:SuzukiPracticeBuddy/pages/appPropertiesBloc.dart';
import 'package:SuzukiPracticeBuddy/pages/home.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventoryLoadingPage.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopItem.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/shopLoadingPage.dart';
import 'package:SuzukiPracticeBuddy/screens/settings/settings.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/databases/database.dart';

import '../review/Piece.dart';

int currentPieceId;
int colorIndex = 0;

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  bool currentPiecePracticedToday;

  //home screen background image
  String backgroundImage;

  //The amount of money a user has, read from the database on startup
  int currencyValue;

  Piece currentPiece;

  List<Piece> allPieces;

  //book properties
  bool bookOpen = false;
  double _leftCoverPos = -125;
  double _rightCoverPos = -125;

  //Badge display properties
  bool selected = false;
  double _pos = -500;
  int taskCounter;
  List<bool> doneStatus = [];

  Map<String, int> badgeHistory = {
    "Mon": 0,
    "Tue": 0,
    "Wed": 0,
    "Thu": 0,
    "Fri": 0,
    "Sat": 0,
    "Sun": 0,
  };

  //Current day of the week
  String day = DateFormat('E').format(DateTime.now());

  //Images to be displayed upon task completion
  List<String> badges = [
    'assets/none_3.svg',
    'assets/bronze_badge_3.svg',
    'assets/silver_badge_3.svg',
    'assets/gold_badge_3.svg'
  ];

  Achievement achievement = Achievement('blank', false, 'blank', 'blank');
  bool newlyCompleted = false;

  Color currentPieceColor;

  //resets the page after navigating to it from the navigation bar.
  //(used to fix shop navigation issue)
  void resetPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => Home(1),
      ),
    );
  }

  getCurrentPiece(int currentPieceId) async {
    var res = await DBProvider.db.getCurrentPiece(currentPieceId);
    return res;
  }

  //Reads database and initialises local values
  Future<String> _initValues(day) async {
    backgroundImage = 'assets/backgrounds/' +
        await GeneralDBProvider.instance.getBackground();
    if (backgroundImage == 'assets/backgrounds/launch_icon-playstore.png')
      backgroundImage = null;

    currentPieceId = await GeneralDBProvider.instance.getCurrentPieceId();
    currentPiece = await getCurrentPiece(currentPieceId);
    allPieces = await DBProvider.db.getPieces();

    taskCounter = await _getTaskCounter(day);

    currentPieceColor = await colorPicker();

    //checking for coin achievements
    int totalCoinsEarned = await GeneralDBProvider.instance.getTotalCoins();
    if (totalCoinsEarned >= 500 && totalCoinsEarned < 1000) {
      achievement =
          await GeneralDBProvider.instance.getAchievement('Coin collector');
      newlyCompleted = await GeneralDBProvider.instance
          .completeAchievement(achievement.name);
    }
    if (totalCoinsEarned >= 1000 && totalCoinsEarned < 1500) {
      achievement =
          await GeneralDBProvider.instance.getAchievement('More coins');
      newlyCompleted = await GeneralDBProvider.instance
          .completeAchievement(achievement.name);
    }
    if (totalCoinsEarned >= 2500 && totalCoinsEarned < 3000) {
      achievement =
          await GeneralDBProvider.instance.getAchievement('Coin expert');
      newlyCompleted = await GeneralDBProvider.instance
          .completeAchievement(achievement.name);
    }
    if (totalCoinsEarned >= 5000 && totalCoinsEarned < 5500) {
      achievement =
          await GeneralDBProvider.instance.getAchievement('Coin master');
      newlyCompleted = await GeneralDBProvider.instance
          .completeAchievement(achievement.name);
    }
    if (totalCoinsEarned >= 10000 && totalCoinsEarned < 10500) {
      achievement =
          await GeneralDBProvider.instance.getAchievement('Filling the bank');
      newlyCompleted = await GeneralDBProvider.instance
          .completeAchievement(achievement.name);
    }

    final player = AudioCache();

    if (newlyCompleted) {
      player.load('achievementIn.mp3');
      player.play('achievementIn.mp3');
      player.load('achievementOut.mp3');
      Flushbar(
        title: achievement.name,
        message: achievement.description,
        duration: Duration(seconds: 3),
        isDismissible: true,
        icon: Image.asset(
          'assets/dollar.png',
          height: 25,
          width: 25,
        ),
        blockBackgroundInteraction: false,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context).then((value) => player.play('achievementOut.mp3'));
    }

    for (String s in badgeHistory.keys) {
      badgeHistory[s] = await _getTaskCounter(s);
    }
    currencyValue = await GeneralDBProvider.instance.getCurrencyValue();
    appBloc.updateCurrencyValue(currencyValue);

    doneStatus = await _getDoneStatus(day);
    if (doneStatus[0] == true) {
      currentPiecePracticedToday = true;
    } else {
      currentPiecePracticedToday = false;
    }

    //handling achievements
    Achievement reviewAchievement = await GeneralDBProvider.instance
        .getAchievement('Practice makes perfect');
    Achievement listeningAchievement =
        await GeneralDBProvider.instance.getAchievement('Using your ears');
    Achievement goldAchievement =
        await GeneralDBProvider.instance.getAchievement('Go for gold!');
    bool newlyCompletedReview = false;
    bool newlyCompletedListening = false;
    bool newlyCompletedGold = false;

    //checks for review achievement
    if (doneStatus[1] == true) {
      newlyCompletedReview = await GeneralDBProvider.instance
          .completeAchievement(reviewAchievement.name);
    }
    //checks for listening task achievement
    if (doneStatus[2] == true) {
      newlyCompletedListening = await GeneralDBProvider.instance
          .completeAchievement(listeningAchievement.name);
    }
    // checks for go for gold achievement
    if (doneStatus[0] == true &&
        doneStatus[1] == true &&
        doneStatus[2] == true) {
      newlyCompletedGold = await GeneralDBProvider.instance
          .completeAchievement(goldAchievement.name);
    }

    Flushbar reviewFlushbar = Flushbar(
      title: reviewAchievement.name,
      message: reviewAchievement.description,
      duration: Duration(seconds: 3),
      isDismissible: true,
      icon: Icon(
        Icons.menu_book,
        color: Colors.white,
      ),
      blockBackgroundInteraction: false,
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
    );

    Flushbar listeningFlushbar = Flushbar(
      title: listeningAchievement.name,
      message: listeningAchievement.description,
      duration: Duration(seconds: 3),
      isDismissible: true,
      icon: Icon(
        Icons.hearing,
        color: Colors.white,
      ),
      blockBackgroundInteraction: false,
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
    );

    Flushbar goldFlushbar = Flushbar(
      title: goldAchievement.name,
      message: goldAchievement.description,
      duration: Duration(seconds: 3),
      isDismissible: true,
      icon: Image.asset(
        'assets/gold_badge_3.png',
        height: 25,
        width: 25,
      ),
      blockBackgroundInteraction: false,
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
    );

    if (newlyCompletedReview && !newlyCompletedGold) {
      final player = AudioCache();
      player.load('achievementIn.mp3');
      player.play('achievementIn.mp3');
      player.load('achievementOut.mp3');
      reviewFlushbar.show(context).then(
            (_) => player.play('achievementOut.mp3'),
          );
    }
    if (newlyCompletedListening && !newlyCompletedGold) {
      final player = AudioCache();
      player.load('achievementIn.mp3');
      player.play('achievementIn.mp3');
      player.load('achievementOut.mp3');
      listeningFlushbar.show(context).then(
            (_) => player.play('achievementOut.mp3'),
          );
    }
    if (newlyCompletedGold &&
        !newlyCompletedListening &&
        !newlyCompletedReview) {
      final player = AudioCache();
      player.load('achievementIn.mp3');
      player.play('achievementIn.mp3');
      player.load('achievementOut.mp3');
      goldFlushbar.show(context).then(
            (_) => player.play('achievementOut.mp3'),
          );
    }
    if (newlyCompletedGold && newlyCompletedListening) {
      final player = AudioCache();
      player.load('achievementIn.mp3');
      player.play('achievementIn.mp3');
      player.load('achievementOut.mp3');
      listeningFlushbar
          .show(context)
          .then(
            (_) => player.play('achievementOut.mp3'),
          )
          .then(
            (_) => goldFlushbar.show(context).then(
                  (_) => player.play('achievementOut.mp3'),
                ),
          );
    }
    if (newlyCompletedGold && newlyCompletedReview) {
      final player = AudioCache();
      player.load('achievementIn.mp3');
      player.play('achievementIn.mp3');
      player.load('achievementOut.mp3');
      reviewFlushbar
          .show(context)
          .then(
            (_) => player.play('achievementOut.mp3'),
          )
          .then(
            (_) => goldFlushbar.show(context).then(
                  (_) => player.play('achievementOut.mp3'),
                ),
          );
    }

    return "Done";
  }

  //Reads database and returns progress made on the given day
  Future<int> _getTaskCounter(String day) async {
    var res = await GeneralDBProvider.instance.getBadgeHistory(day);
    taskCounter = res[0]['taskCounter'];
    return taskCounter;
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

  //Updates progress and writes to the database
  updateCurrentPiece() async {
    currentPiece = await DBProvider.db.getCurrentPiece(currentPieceId);
  }

  currentPiecePracticed() async {
    currentPiecePracticedToday = true;
    doneStatus = await _getDoneStatus(day);
    taskCounter = await _getTaskCounter(day);
    if (!doneStatus[0]) {
      taskCounter++;
      doneStatus[0] = true;
      GeneralDBProvider.instance
          .updateBadgeHistory(day, taskCounter, doneStatus);
    }
    setState(() {});
  }

  List<ShopItem> shopItems;

  getShopItems() async {
    shopItems = await GeneralDBProvider.instance.getShopItems();
  }

  displayProgress() {
    _pos = selected ? -500 : 0;
    selected = !selected;
  }

  colorPicker() {
    List<Color> colors = [
      Colors.blueAccent,
      Colors.purple,
      Colors.orange,
      Colors.red,
      Colors.green
    ];
    int index;
    allPieces.forEach(
      (e) {
        if (e.name == currentPiece.name) {
          index = allPieces.indexOf(e);
        }
      },
    );
    while (index >= 5) {
      index = index - 5;
    }
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    if (backgroundImage != null)
      precacheImage(AssetImage(backgroundImage), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _initValues(day),
        //Reads database values before building widgets
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingWidget(); //Displays loading icon while reading
          }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: "shop",
              child: Icon(Icons.shopping_cart_outlined),
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        ShopLoadingPage(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBar(
                // title: Text(
                //   'Suzuki Practice Buddy',
                //   style: TextStyle(color: Colors.white, fontSize: 18),
                // ),
                centerTitle: true,
                backgroundColor: Colors.black,
                title: IconButton(
                  iconSize: 10,
                  icon: SvgPicture.asset(badges[badgeHistory[day]]),
                  onPressed: () {
                    setState(() {
                      _pos = selected ? -500 : 0;
                      selected = !selected;
                    });
                  },
                ),
                leading: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Settings();
                      },
                    );
                  },
                ),
                actions: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: Center(
                      child: Image.asset(
                        'assets/dollar.png',
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                  Center(
                    child: StreamBuilder<Object>(
                        stream: appBloc.currencyStream,
                        initialData: currencyValue,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: backgroundImage == null
                    ? null
                    : DecorationImage(
                        image: AssetImage(backgroundImage),
                        fit: BoxFit.cover,
                      ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  //current piece book
                  Container(
                    alignment: Alignment.center,
                    child: BookBody(
                        currentPiece,
                        currentPiecePracticed,
                        currentPiecePracticedToday,
                        updateCurrentPiece,
                        allPieces,
                        badgeHistory[day],
                        currentPieceColor),
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
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      heroTag: "inventory",
                      child: Icon(Icons.inventory),
                      backgroundColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        InventoryLoadingPage(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            )
                            .then((val) => val ? resetPage() : null);
                      },
                    ),
                  ),
                  AnimatedPositioned(
                    top: _pos,
                    left: 0,
                    right: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          height: 300,
                          width: 500,
                          decoration: new BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black26),
                          ),
                        ),
                        new Positioned(
                          top: 20,
                          left: 10,
                          child: new SvgPicture.asset(badges[badgeHistory[day]],
                              height: 150, width: 150),
                        ),
                        new Positioned(
                          top: 20,
                          left: 160,
                          child: new Text(
                            "Badges",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Arial",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        new Positioned(
                          top: 50,
                          left: 160,
                          child: new Text(
                            "Complete tasks to advance",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Arial",
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        new Positioned(
                          top: 70,
                          left: 160,
                          child: new Text(
                            "your rank",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Arial",
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        new Positioned.fill(
                          top: 120,
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: new Text(
                                  "M",
                                  style: TextStyle(
                                      color: day != "Mon"
                                          ? Colors.white
                                          : Colors.orange,
                                      // shadows: day != "Mon" ? <Shadow>[] : <Shadow>[
                                      //   Shadow(
                                      //     blurRadius: 2.0,
                                      //     color: Colors.orangeAccent,
                                      //   )
                                      // ],
                                      fontFamily: "Arial",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: new Text(
                                  "Tu",
                                  style: TextStyle(
                                      color: day != "Tue"
                                          ? Colors.white
                                          : Colors.orange,
                                      fontFamily: "Arial",
                                      // shadows: <Shadow>[
                                      //   Shadow(
                                      //     blurRadius: 2.0,
                                      //     color: day != "Tue"
                                      //         ? Colors.white
                                      //         : Colors.orangeAccent,
                                      //   )
                                      // ],
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: new Text(
                                  "W",
                                  style: TextStyle(
                                      color: day != "Wed"
                                          ? Colors.white
                                          : Colors.orange,
                                      // shadows: day != "Wed" ? <Shadow>[] : <Shadow>[
                                      //   Shadow(
                                      //     blurRadius: 3.0,
                                      //     color: Colors.orangeAccent,
                                      //   )
                                      // ],
                                      fontFamily: "Arial",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: new Text(
                                  "Th",
                                  style: TextStyle(
                                      color: day != "Thu"
                                          ? Colors.white
                                          : Colors.orange,
                                      // shadows: <Shadow>[
                                      //   Shadow(
                                      //     blurRadius: 2.0,
                                      //     color: day != "Thu"
                                      //         ? Colors.white
                                      //         : Colors.orangeAccent,
                                      //   )
                                      // ],
                                      fontFamily: "Arial",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: new Text(
                                  "F",
                                  style: TextStyle(
                                      color: day != "Fri"
                                          ? Colors.white
                                          : Colors.orange,
                                      // shadows: <Shadow>[
                                      //   Shadow(
                                      //     blurRadius: 2.0,
                                      //     color: day != "Fri"
                                      //         ? Colors.white
                                      //         : Colors.orangeAccent,
                                      //   )
                                      // ],
                                      fontFamily: "Arial",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: new Text(
                                  "Sa",
                                  style: TextStyle(
                                      color: day != "Sat"
                                          ? Colors.white
                                          : Colors.orange,
                                      // shadows: <Shadow>[
                                      //   Shadow(
                                      //     blurRadius: 2.0,
                                      //     color: day != "Sat"
                                      //         ? Colors.white
                                      //         : Colors.orangeAccent,
                                      //   )
                                      // ],
                                      fontFamily: "Arial",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              new Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: new Text(
                                  "Su",
                                  style: TextStyle(
                                      color: day != "Sun"
                                          ? Colors.white
                                          : Colors.orange,
                                      // shadows: <Shadow>[
                                      //   Shadow(
                                      //     blurRadius: 2.0,
                                      //     color: day != "Sun"
                                      //         ? Colors.white
                                      //         : Colors.orangeAccent,
                                      //   )
                                      // ],
                                      fontFamily: "Arial",
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Positioned.fill(
                          top: 220,
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new SvgPicture.asset(badges[badgeHistory["Mon"]],
                                  height: 50, width: 50),
                              new SvgPicture.asset(badges[badgeHistory["Tue"]],
                                  height: 50, width: 50),
                              new SvgPicture.asset(badges[badgeHistory["Wed"]],
                                  height: 50, width: 50),
                              new SvgPicture.asset(badges[badgeHistory["Thu"]],
                                  height: 50, width: 50),
                              new SvgPicture.asset(badges[badgeHistory["Fri"]],
                                  height: 50, width: 50),
                              new SvgPicture.asset(badges[badgeHistory["Sat"]],
                                  height: 50, width: 50),
                              new SvgPicture.asset(badges[badgeHistory["Sun"]],
                                  height: 50, width: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
