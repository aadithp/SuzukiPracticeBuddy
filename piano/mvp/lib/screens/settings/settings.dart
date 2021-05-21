import 'package:SuzukiPracticeBuddy/pages/achievements/achievements.dart';
import 'package:SuzukiPracticeBuddy/pages/tutorial/TP1.dart';
import 'package:SuzukiPracticeBuddy/screens/settings/resetConfirmation.dart';
import 'package:flutter/material.dart';

var dropdownValue;

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
            image: AssetImage(
              'assets/settings.png',
            ),
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 220, 0, 0),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(9)
                ),
                width: 270,
                height: 75,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            Achievements(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
                  child: Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(9)
                ),
                width: 270,
                height: 75,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            TP1(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (c, a1, a2) => TP1(),
                    //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                    //     transitionDuration: Duration(milliseconds: 2000),
                    //   ),
                    // );
                  },
                  child: Text(
                    'Tutorial',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(9)
              ),
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  "Reset all progress",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ResetConfirmation();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
