import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/otherWidgets/loadingWidget.dart';
import 'package:SuzukiPracticeBuddy/pages/achievements/achievement.dart';
import 'package:SuzukiPracticeBuddy/pages/achievements/achievementItem.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Achievements extends StatefulWidget {
  @override
  _AchievementsState createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  List<Achievement> achievements;
  int numberCompleted = 0;
  Color numberColor;

  getAchievements() async {
    numberCompleted = 0;
    achievements = await GeneralDBProvider.instance.getAllAchievements();
    for (int x = 0; x < achievements.length; x++) {
      if (achievements[x].completeStatus == true) {
        numberCompleted++;
      }
    }
    if (numberCompleted == achievements.length) {
      Achievement achievement =
          await GeneralDBProvider.instance.getAchievement('Completionist');
      bool newlyCompleted = await GeneralDBProvider.instance
          .completeAchievement(achievement.name);
      if (newlyCompleted) {
        setState(() {});
        final player = AudioCache();
        player.load('achievementIn.mp3');
        player.play('achievementIn.mp3');
        player.load('achievementOut.mp3');
        Flushbar(
          title: achievement.name,
          message: achievement.description,
          duration: Duration(seconds: 3),
          isDismissible: true,
          icon: Image.asset(
            'assets/completionistEdit.png',
            height: 25,
            width: 25,
          ),
          blockBackgroundInteraction: false,
          dismissDirection: FlushbarDismissDirection.VERTICAL,
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context).then((value) => player.play('achievementOut.mp3'));
      }
    }
    if (numberCompleted < 1) {
      numberColor = Colors.red;
    } else {
      if (numberCompleted >= 1 && numberCompleted < achievements.length) {
        numberColor = Colors.yellow;
      } else {
        numberColor = Colors.green;
      }
    }

    return achievements;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAchievements(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingWidget(); //Displays loading icon while reading
        }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              title: Text('Achievements'),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 7, 3, 0),
                  child: Text(
                    numberCompleted.toString(),
                    style: TextStyle(
                      color: numberColor,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 7, 7, 0),
                  child: Text(
                    '/' + achievements.length.toString(),
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    achievements.length,
                    (index) {
                      return Center(
                          child: AchievementItem(achievements[index]));
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
