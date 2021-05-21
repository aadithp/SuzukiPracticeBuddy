import 'package:flutter/material.dart';

class RightBookCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
              'assets/practice_book_cover_single_note_black_right.jpg'),
        ),
        border: Border(
          top: BorderSide(width: 3, color: Colors.white),
          right: BorderSide(width: 3, color: Colors.white),
          bottom: BorderSide(width: 3, color: Colors.white),
        ),
      ),
    );
  }
}
