import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/screens/studentHomePage/Promotion.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PiecePracticedButton extends StatefulWidget {
  final Function currentPiecePracticed;
  final int taskCounter;

  PiecePracticedButton(this.currentPiecePracticed, this.taskCounter);

  @override
  _PiecePracticedButtonState createState() =>
      _PiecePracticedButtonState(currentPiecePracticed, taskCounter);
}

class _PiecePracticedButtonState extends State<PiecePracticedButton> {
  Function currentPiecePracticed;
  int taskCounter;

  _PiecePracticedButtonState(this.currentPiecePracticed, this.taskCounter);

  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        onPressed: () async {
          //award user coins for completing task
          await GeneralDBProvider.instance.awardCoins(100);
          currentPiecePracticed();
          if (taskCounter < 3) {
            player.play('pianoJingle.mp3');
            SystemChrome.setEnabledSystemUIOverlays([]);
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return Promotion(taskCounter + 1);
              },
            );
          }
        },
        child: Container(
          child: Text('Practiced today'),
        ),
      ),
    );
  }
}
