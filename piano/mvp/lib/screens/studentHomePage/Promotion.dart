import 'dart:async';
import 'package:SuzukiPracticeBuddy/pages/homeLoadingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Promotion extends StatefulWidget {
  final int badgeNumber;

  Promotion(this.badgeNumber);

  _PromotionState createState() =>
      _PromotionState(this.badgeNumber);
}

class _PromotionState extends State<Promotion>
    with SingleTickerProviderStateMixin {
  AnimationController rotationController;
  int badgeNumber;
  double _pos = 1000;
  double _buttonAlpha = 0;
  double _coinsAlpha = 0;

  //Images to be displayed upon task completion
  List<String> badges = [
    'assets/none_3.svg',
    'assets/bronze_badge_3.svg',
    'assets/silver_badge_3.svg',
    'assets/gold_badge_3.svg'
  ];

  Timer _badgeTimer;
  Timer _buttonTimer;
  Timer _coinsTimer;

  _PromotionState(this.badgeNumber) {
    _badgeTimer = new Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _pos = 50;
        _coinsTimer = new Timer(const Duration(seconds: 1), () {
          setState(() {
            _coinsAlpha = 1;
          });
        });
        _buttonTimer = new Timer(const Duration(seconds: 1), () {
          setState(() {
            _buttonAlpha = 1;
            dispose();
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _badgeTimer.cancel();
    _coinsTimer.cancel();
    _buttonTimer.cancel();
  }

  @override
  void initState() {
    rotationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    rotationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              top: _pos,
              left: 0,
              right: 0,
              child: SvgPicture.asset(badges[badgeNumber],
                  width: 350, height: 350),
              duration: Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
            ),
            Positioned(
              top: 457,
              left: 20,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  duration: Duration(seconds: 2),
                  opacity: _coinsAlpha,
                  child: Text(
                    "100",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 3.0,
                          color: Colors.yellowAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 465,
              left: 0,
              right: 60,
              child: Center(
                child: AnimatedOpacity(
                  duration: Duration(seconds: 2),
                  opacity: _coinsAlpha,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: Center(
                      child: Image.asset(
                        'assets/dollar.png',
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 550,
              left: 0,
              right: 0,
              child: Container(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                HomeLoadingPage(1),
                            transitionDuration: Duration(seconds: 0)),
                        (Route<dynamic> route) => false);
                  },
                  child: Center(
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 2),
                      opacity: _buttonAlpha,
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
                              'Collect',
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
        ),
      ),
    );
  }
}
