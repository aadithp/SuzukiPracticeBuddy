import 'dart:core';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP1.dart';
import 'package:flutter/material.dart';
import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/databases/database.dart';
import 'pages/home.dart';

void main() => runApp(PianoApp());

class PianoApp extends StatefulWidget {
  @override
  _PianoAppState createState() => _PianoAppState();
}

class _PianoAppState extends State<PianoApp> {
  Map<String, int> badgeHistory = {
    "Mon": 0,
    "Tue": 0,
    "Wed": 0,
    "Thu": 0,
    "Fri": 0,
    "Sat": 0,
    "Sun": 0,
  };

  bool firstAccess = false;
  //Local variables to store progress made on the current day
  int taskCounter;
  List<bool> doneStatus = [];

  //Current day of the week
  String day = DateFormat('E').format(DateTime.now());

  //Reads database and initialises local values
  Future<String> _initValues(day) async {
    taskCounter = await _getTaskCounter(day);
    for (String s in badgeHistory.keys) {
      badgeHistory[s] = await _getTaskCounter(s);
    }
    var access = await GeneralDBProvider.instance.getAccess();
    print(access);
    if (access[0]['firstAccess'] == 'true') {
      firstAccess = true;
      await GeneralDBProvider.instance.updateAccess();
      print(await GeneralDBProvider.instance.getAccess());
    }
    return "Done";
  }

  //Reads database and returns progress made on the given day
  Future<int> _getTaskCounter(String day) async {
    var res = await GeneralDBProvider.instance.getBadgeHistory(day);
    taskCounter = res[0]['taskCounter'];
    return taskCounter;
  }

  @override
  Widget build(BuildContext context) {
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
              return new Stack(
                  alignment: FractionalOffset.center,
                  children: <Widget>[
                    new Container(
                      color: Colors.white,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset('assets/launch_icon-playstore.png',
                          height: 70, width: 70),
                    ),
                    Positioned(
                      bottom: 300,
                      child: new CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  ]); //Displays loading icon while reading
            }
            SystemChrome.setEnabledSystemUIOverlays([]);
            if (firstAccess) {
              return TP1();
            }
            return Home(1);
          }),
    );
  }
}
