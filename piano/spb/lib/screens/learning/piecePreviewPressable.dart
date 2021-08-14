import 'package:SuzukiPracticeBuddy/databases/database.dart';
import 'package:SuzukiPracticeBuddy/databases/generalDatabase.dart';
import 'package:SuzukiPracticeBuddy/pages/homeLoadingPage.dart';
import 'package:SuzukiPracticeBuddy/screens/review/Piece.dart';
import 'package:SuzukiPracticeBuddy/screens/review/PiecePreview.dart';
import 'package:SuzukiPracticeBuddy/screens/review/ReviewPieceIds.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

class PiecePreviewPressable extends StatelessWidget {
  final Piece piece;
  final Function updateCurrentPiece;
  final Piece currentPiece;
  final Color color;

  PiecePreviewPressable(this.piece, this.updateCurrentPiece, this.currentPiece, this.color,);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          await GeneralDBProvider.instance.updateCurrentPieceId(piece.id);
          var res = await DBProvider.db.getReviewPieceIds(piece.id);
          ReviewPieceIds reviewPieceIds = ReviewPieceIds.convertToList(res[0]);
          res = await DBProvider.db.updateReviewPiecesTable(reviewPieceIds);
          updateCurrentPiece();
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => HomeLoadingPage(1),
              transitionDuration: Duration(seconds: 0),
            ), (Route<dynamic> route) => false);
        },
        child: ConditionalBuilder(
          condition: currentPiece.name == piece.name,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: PiecePreview(piece, color),
            );
          },
          fallback: (context) {
            return PiecePreview(piece, color);
          },
        ),
      ),
    );
  }
}
