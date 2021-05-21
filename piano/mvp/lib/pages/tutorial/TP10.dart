import 'package:SuzukiPracticeBuddy/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TP10 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP10State();
}

class TP10State extends State<TP10> {
  //Display properties
  double _alpha1 = 1;
  double _alpha2 = 0;
  double _alpha3 = 0;
  double _alpha4 = 0;
  double _alpha5 = 0;
  double _alpha6 = 0;

  //Badge display properties
  bool selected = false;
  double _pos = -500;
  int taskCounter;
  List<bool> doneStatus = [];

  //Current day of the week
  String day = DateFormat('E').format(DateTime.now());


  Map<String, int> badgeHistory = {
    "Mon": 0,
    "Tue": 0,
    "Wed": 0,
    "Thu": 0,
    "Fri": 0,
    "Sat": 0,
    "Sun": 0,
  };

  List<String> badges = [
    'assets/none_3.svg',
    'assets/bronze_badge_3.svg',
    'assets/silver_badge_3.svg',
    'assets/gold_badge_3.svg'
  ];

  @override
  initState() {
    toggleOpacity();
    super.initState();
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
                      top: MediaQuery.of(context).size.height*0.41,
                      child: AnimatedOpacity(
                        opacity: _alpha2,
                        duration: Duration(seconds: 1),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("That's the end of the tutorial!", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                          )
                      )
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.44,
                      child: AnimatedOpacity(
                          opacity: _alpha2,
                          duration: Duration(seconds: 1),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("You can watch the tutorial again by tapping the button in the settings page.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                          )
                      )
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height*0.6,
                      child: AnimatedOpacity(
                        opacity: _alpha3,
                        duration: Duration(seconds: 1),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Have fun practising!", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                          )
                      )
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
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => Home(1),
                                      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 500),
                                    ),
                                      (r) => false
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
            ),
        ),
    );
  }
}
