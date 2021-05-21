import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Piece.dart';

class PiecePreview extends StatelessWidget {
  final Piece piece;
  final Color color;
  PiecePreview(this.piece, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Container(
        width: 42,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          //add randomised colour selector here
          borderRadius: BorderRadius.circular(10.0),
          // boxShadow: [
          //   BoxShadow(
          //       offset: Offset(0, 17),
          //       blurRadius: 50,
          //       spreadRadius: -5,
          //       color: Colors.white12)
          // ],
        ),
        child: Center(
          child: Text(
            piece.name,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
//   return SizedBox(
//     width: 100,
//     height: 75,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.blueGrey,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: Colors.black,
//           width: 3,
//         ),
//       ),
//       child: Row(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.black,
//                   width: 2,
//                 ),
//               ),
//               height: 65,
//               width: 65,
//               child: Image.asset(
//                 'assets/pp1.png',
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//             child: Text('Student name: ' +
//                 piece.name),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
