import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/loadingWidgetNoAppbar.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Listening extends StatelessWidget {
  final Function updateParent;

  Listening(this.updateParent);

  final player = AudioCache();

  //Current day of the week
  String day = DateFormat('E').format(DateTime.now());

  List<bool> doneStatus = [];
  bool listeningDone;
  int taskCounter;

  //Reads database and returns list of booleans representing completed tasks
  Future<List<bool>> _getDoneStatus(String day) async {
    var res = await GeneralDBProvider.instance.getBadgeHistory(day);
    List<String> statusStrings = res[0]['doneStatus'].split(",");
    doneStatus.clear();
    taskCounter = 0;
    for (String s in statusStrings) {
      switch (s) {
        case "true":
          doneStatus.add(true);
          taskCounter++;
          break;
        case "false":
          doneStatus.add(false);
          break;
      }
    }
    return doneStatus;
  }

  _initValues() async {
    doneStatus = await _getDoneStatus(day);
    listeningDone = doneStatus[2];
    return 'done';
  }

  @override
  Widget build(BuildContext context) {
    player.load('pianoJingle.mp3');

    Widget yesButton = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      width: 130,
      height: 50,
      margin: EdgeInsets.all(90),
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.green,
        textColor: Colors.white,
        child: Text(
          'Yes',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        onPressed: () async {
          updateParent(context);
        },
      ),
    );

    return Scaffold(
      body: FutureBuilder(
        future: _initValues(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData || listeningDone == null) {
            return LoadingWidgetNoAppBar();
          }
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: AssetImage(
                  'assets/listeningBackgroundEdit.png',
                ),
              ),
            ),
            child: !listeningDone
                ? Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 280, 0, 0),
                        ),
                        Container(
                          child: Stack(
                            children: <Widget>[
                              Opacity(
                                opacity: 0.7,
                                child: Container(
                                  child: SizedBox(
                                    width: 300,
                                    height: 180,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                width: 300,
                                height: 100,
                                child: Text(
                                  'Have you completed your listening task?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: yesButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Opacity(
                              opacity: 0.7,
                              child: Container(
                                child: SizedBox(
                                  width: 300,
                                  height: 130,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 180,
                              width: 300,
                              child: Text(
                                "You've already completed your listening task for today!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
