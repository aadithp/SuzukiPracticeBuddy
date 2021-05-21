import 'package:SuzukiPracticeBuddy/pages/achievements/achievement.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  final Achievement achievement;

  AchievementItem(this.achievement);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConditionalBuilder(
        condition: achievement.completeStatus,
        builder: (context) {
          return Container(
            width: 175,
            height: 175,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/' + achievement.image,
                ),
              ),
              border: Border.all(color: Colors.black, width: 2),
            ),
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 175 * 0.75, 0, 0),
                  child: Opacity(
                    opacity: 0.6,
                    child: SizedBox(
                      width: 175,
                      height: 175 / 4,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 175 * 0.77, 0, 0),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          achievement.name,
                          style: TextStyle(
                              fontSize: 175 * 0.08, color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            achievement.description,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        fallback: (context) {return Container(
          width: 175,
          height: 175,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.color),
              image: AssetImage(
                'assets/' + achievement.image,
              ),
            ),
            border: Border.all(color: Colors.black, width: 2),
          ),
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 175 * 0.75, 0, 0),
                child: Opacity(
                  opacity: 0.6,
                  child: SizedBox(
                    width: 175,
                    height: 175 / 4,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 175 * 0.77, 0, 0),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        achievement.name,
                        style: TextStyle(
                            fontSize: 175 * 0.08, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          achievement.description,
                          style: TextStyle(
                              fontSize: 11, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );},
      ),
    );
  }
}
