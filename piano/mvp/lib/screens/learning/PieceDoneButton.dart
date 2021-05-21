import 'package:SuzukiPracticeBuddy/otherWidgets/coins.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/databases/database.dart';
import '../review/Piece.dart';
import '../review/ReviewPieceIds.dart';

class PieceDoneButton extends StatelessWidget {
  final Piece currentPiece;
  final Function() updateParent;
  PieceDoneButton(this.currentPiece, {Key key, @required this.updateParent})
      : super(key: key);

  updateReviewList(int currentPieceId) async {
    var res = await DBProvider.db.getNextCurrentPiece(currentPieceId);
    res = Piece.convertToPiece(res[0]);
    currentPieceId = res.id;
    res = await DBProvider.db.getReviewPieceIds(currentPieceId);
    ReviewPieceIds reviewPieceIds = ReviewPieceIds.convertToList(res[0]);
    res = await DBProvider.db.updateReviewPiecesTable(reviewPieceIds);
    return res;
  }

  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    player.load('pianoJingle.mp3');
    // ignore: deprecated_member_use
    return RaisedButton(
      child: Text("Mark as done"),
      onPressed: () async {
        player.play('pianoJingle.mp3');
        await showDialog(
          context: context,
          builder: (BuildContext context) =>
              Coins(),
        );
        //award user coins for completing task
        await GeneralDBProvider.instance.awardCoins(100);
        await updateReviewList(currentPiece.id);
        updateParent();
        Navigator.pop(context, true);
      },
    );
  }
}
