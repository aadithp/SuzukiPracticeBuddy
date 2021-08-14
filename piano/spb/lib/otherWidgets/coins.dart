import 'package:SuzukiPracticeBuddy/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Coins extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 400,
            height: 450,
            child: Lottie.asset(
              'assets/coinsAnimation.json',
              repeat: true,
            ),
          ),
          SizedBox(
            width: 200,
            child: Container(
              child: Text(
                'You earned 100 coins!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, _, __) =>
                          Home(1)),
                      (r) => false);
            },
            child: Text(
              'Collect',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
