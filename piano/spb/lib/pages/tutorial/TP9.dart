import 'package:SuzukiPracticeBuddy/pages/tutorial/TP10.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


class TP9 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TP9State();
}

class TP9State extends State<TP9> {
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
                    top: MediaQuery.of(context).size.height*0.36,
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: _alpha2,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("You can also view your progress by tapping the badge icon at the top of the home page.", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                        )
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.52,
                    child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: _alpha3,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Try this with the badge below!", style: TextStyle(fontSize: 22,), textAlign: TextAlign.center,)
                        )
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.58,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: _alpha4,
                      child: IconButton(
                        iconSize: 50,
                        icon: SvgPicture.asset('assets/none_3.svg'),
                        onPressed: () {
                          setState(() {
                            _pos = selected ? -500 : 0;
                            selected = !selected;
                            Future.delayed(Duration(seconds: 1), () {setState(() {
                              _alpha5 = 1;
                            });});
                            Future.delayed(Duration(seconds: 2), () { setState(() {
                              _alpha6 = 1;
                            });});
                          });
                        },
                      ),
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
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.73,
                    child: AnimatedOpacity(
                        opacity: _alpha5,
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
                          opacity: _alpha6,
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
                                      pageBuilder: (c, a1, a2) => TP10(),
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
                  _alpha6 == 0 ? Positioned(
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
                ]
            ))
    );
  }
}
